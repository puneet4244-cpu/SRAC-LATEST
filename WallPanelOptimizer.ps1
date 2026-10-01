Add-Type -ReferencedAssemblies System.Drawing -TypeDefinition @"
using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;

public class WallPanelOptimizer {
    public static Bitmap Process(
        string rawPath, 
        int cropX, 
        int cropY, 
        int cropW, 
        int cropH, 
        float contrast, 
        float brightness, 
        float warmth,
        float sharpenAmount
    ) {
        int targetW = 900;
        int targetH = 1200;

        using (Image src = Image.FromFile(rawPath)) {
            // 1. Initial High-Quality Crop and Scale
            Bitmap resampled = new Bitmap(targetW, targetH, PixelFormat.Format32bppArgb);
            using (Graphics g = Graphics.FromImage(resampled)) {
                g.InterpolationMode = InterpolationMode.HighQualityBicubic;
                g.SmoothingMode = SmoothingMode.HighQuality;
                g.PixelOffsetMode = PixelOffsetMode.HighQuality;
                g.CompositingQuality = CompositingQuality.HighQuality;

                Rectangle destRect = new Rectangle(0, 0, targetW, targetH);
                g.DrawImage(src, destRect, cropX, cropY, cropW, cropH, GraphicsUnit.Pixel);
            }

            // 2. Pixel-level Clarity, Micro-contrast & Unsharp Sharpening
            Bitmap retouched = new Bitmap(targetW, targetH, PixelFormat.Format32bppArgb);
            
            BitmapData srcData = resampled.LockBits(
                new Rectangle(0, 0, targetW, targetH), 
                ImageLockMode.ReadOnly, 
                PixelFormat.Format32bppArgb
            );
            BitmapData dstData = retouched.LockBits(
                new Rectangle(0, 0, targetW, targetH), 
                ImageLockMode.WriteOnly, 
                PixelFormat.Format32bppArgb
            );

            int stride = srcData.Stride;
            IntPtr srcScan0 = srcData.Scan0;
            IntPtr dstScan0 = dstData.Scan0;

            unsafe {
                byte* pSrc = (byte*)srcScan0;
                byte* pDst = (byte*)dstScan0;

                // Color curve pre-calc
                float c = contrast;
                float b = brightness;
                float t = (1.0f - c) / 2.0f + b;

                // Tone mapping loop with Laplacian edge enhancement (sharpening stone carvings)
                for (int y = 1; y < targetH - 1; y++) {
                    byte* rowPrev = pSrc + (y - 1) * stride;
                    byte* rowCurr = pSrc + y * stride;
                    byte* rowNext = pSrc + (y + 1) * stride;
                    byte* rowOut  = pDst + y * stride;

                    for (int x = 1; x < targetW - 1; x++) {
                        int px = x * 4;
                        int pxL = (x - 1) * 4;
                        int pxR = (x + 1) * 4;

                        // Calculate Laplacian for B, G, R
                        for (int ch = 0; ch < 3; ch++) {
                            float center = rowCurr[px + ch];
                            float up     = rowPrev[px + ch];
                            float down   = rowNext[px + ch];
                            float left   = rowCurr[pxL + ch];
                            float right  = rowCurr[pxR + ch];

                            // Edge detail
                            float laplacian = (4.0f * center - up - down - left - right);
                            float sharpened = center + laplacian * (sharpenAmount * 0.22f);

                            // Normalize 0..1
                            float norm = sharpened / 255.0f;

                            // Apply Contrast & Warmth
                            float tuned;
                            if (ch == 2) { // Red (boost for warm cream stone)
                                tuned = (norm * c + t) + warmth;
                            } else if (ch == 1) { // Green
                                tuned = (norm * c + t) + (warmth * 0.55f);
                            } else { // Blue (reduce slightly to kill blue/grey cold cast)
                                tuned = (norm * c + t) - (warmth * 0.35f);
                            }

                            int finalVal = (int)(tuned * 255.0f);
                            if (finalVal < 0) finalVal = 0;
                            if (finalVal > 255) finalVal = 255;

                            rowOut[px + ch] = (byte)finalVal;
                        }
                        rowOut[px + 3] = 255; // Alpha
                    }
                }
            }

            resampled.UnlockBits(srcData);
            retouched.UnlockBits(dstData);
            resampled.Dispose();

            // 3. Render Center Watermark & Finished Typography
            using (Graphics g = Graphics.FromImage(retouched)) {
                g.SmoothingMode = SmoothingMode.HighQuality;
                g.TextRenderingHint = System.Drawing.Text.TextRenderingHint.AntiAliasGridFit;

                float centerY = 580.0f;
                float line1Size = 34.0f;
                float line2Size = 17.5f;

                using (Font mainFont = new Font("Georgia", line1Size, FontStyle.Bold))
                using (Font subFont = new Font("Arial", line2Size, FontStyle.Bold))
                using (SolidBrush goldBrush = new SolidBrush(Color.FromArgb(195, 238, 180, 92)))
                using (SolidBrush shadowBrush = new SolidBrush(Color.FromArgb(145, 15, 15, 15)))
                using (SolidBrush shadowSoftBrush = new SolidBrush(Color.FromArgb(75, 10, 10, 10))) {

                    StringFormat sfCenter = new StringFormat();
                    sfCenter.Alignment = StringAlignment.Center;
                    sfCenter.LineAlignment = StringAlignment.Center;

                    StringFormat sfRight = new StringFormat();
                    sfRight.Alignment = StringAlignment.Far;
                    sfRight.LineAlignment = StringAlignment.Center;

                    float offset = 2.0f;

                    // Line 1: "Shree Ram & Company"
                    float rect1Y = centerY - (line1Size * 0.85f);
                    RectangleF rect1 = new RectangleF(0, rect1Y, targetW, line1Size * 1.8f);
                    RectangleF rect1Shadow = new RectangleF(offset, rect1Y + offset, targetW, line1Size * 1.8f);
                    RectangleF rect1ShadowSoft = new RectangleF(offset * 1.8f, rect1Y + (offset * 1.8f), targetW, line1Size * 1.8f);

                    g.DrawString("Shree Ram & Company", mainFont, shadowSoftBrush, rect1ShadowSoft, sfCenter);
                    g.DrawString("Shree Ram & Company", mainFont, shadowBrush, rect1Shadow, sfCenter);
                    g.DrawString("Shree Ram & Company", mainFont, goldBrush, rect1, sfCenter);

                    // Line 2: "Vijeta Stone"
                    float rect2Y = centerY + (line1Size * 0.45f);
                    float marginRight = targetW * 0.21f;
                    RectangleF rect2 = new RectangleF(0, rect2Y, targetW - marginRight, line2Size * 1.8f);
                    RectangleF rect2Shadow = new RectangleF(offset, rect2Y + offset, targetW - marginRight, line2Size * 1.8f);

                    g.DrawString("Vijeta Stone", subFont, shadowBrush, rect2Shadow, sfRight);
                    g.DrawString("Vijeta Stone", subFont, goldBrush, rect2, sfRight);
                }
            }

            return retouched;
        }
    }
}
"@
