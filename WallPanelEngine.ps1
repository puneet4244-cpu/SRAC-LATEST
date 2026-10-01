Add-Type -ReferencedAssemblies System.Drawing -TypeDefinition @"
using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Runtime.InteropServices;

public class WallPanelEngine {
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
            Bitmap resampled = new Bitmap(targetW, targetH, PixelFormat.Format32bppArgb);
            using (Graphics g = Graphics.FromImage(resampled)) {
                g.InterpolationMode = InterpolationMode.HighQualityBicubic;
                g.SmoothingMode = SmoothingMode.HighQuality;
                g.PixelOffsetMode = PixelOffsetMode.HighQuality;
                g.CompositingQuality = CompositingQuality.HighQuality;

                Rectangle destRect = new Rectangle(0, 0, targetW, targetH);
                g.DrawImage(src, destRect, cropX, cropY, cropW, cropH, GraphicsUnit.Pixel);
            }

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
            int totalBytes = stride * targetH;
            byte[] srcBytes = new byte[totalBytes];
            byte[] dstBytes = new byte[totalBytes];

            Marshal.Copy(srcData.Scan0, srcBytes, 0, totalBytes);
            Array.Copy(srcBytes, dstBytes, totalBytes);

            float c = contrast;
            float b = brightness;
            float t = (1.0f - c) / 2.0f + b;

            for (int y = 1; y < targetH - 1; y++) {
                int rowPrev = (y - 1) * stride;
                int rowCurr = y * stride;
                int rowNext = (y + 1) * stride;

                for (int x = 1; x < targetW - 1; x++) {
                    int px = rowCurr + x * 4;
                    int pxL = rowCurr + (x - 1) * 4;
                    int pxR = rowCurr + (x + 1) * 4;
                    int pxU = rowPrev + x * 4;
                    int pxD = rowNext + x * 4;

                    for (int ch = 0; ch < 3; ch++) {
                        float center = srcBytes[px + ch];
                        float up     = srcBytes[pxU + ch];
                        float down   = srcBytes[pxD + ch];
                        float left   = srcBytes[pxL + ch];
                        float right  = srcBytes[pxR + ch];

                        // Laplacian edge enhancement for tactile stone chisel detail
                        float laplacian = (4.0f * center - up - down - left - right);
                        float sharpened = center + laplacian * (sharpenAmount * 0.28f);

                        float norm = sharpened / 255.0f;

                        // S-curve contrast and warm Gwalior stone grading
                        float tuned;
                        if (ch == 2) { // Red
                            tuned = (norm * c + t) + warmth;
                        } else if (ch == 1) { // Green
                            tuned = (norm * c + t) + (warmth * 0.52f);
                        } else { // Blue
                            tuned = (norm * c + t) - (warmth * 0.38f);
                        }

                        int finalVal = (int)(tuned * 255.0f);
                        if (finalVal < 0) finalVal = 0;
                        if (finalVal > 255) finalVal = 255;

                        dstBytes[px + ch] = (byte)finalVal;
                    }
                    dstBytes[px + 3] = 255;
                }
            }

            Marshal.Copy(dstBytes, 0, dstData.Scan0, totalBytes);

            resampled.UnlockBits(srcData);
            retouched.UnlockBits(dstData);
            resampled.Dispose();

            // Render Center Watermark & Finished Typography
            using (Graphics g = Graphics.FromImage(retouched)) {
                g.SmoothingMode = SmoothingMode.HighQuality;
                g.TextRenderingHint = System.Drawing.Text.TextRenderingHint.AntiAliasGridFit;

                float centerY = 590.0f;
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
