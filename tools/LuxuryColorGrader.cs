using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.Runtime.InteropServices;

public class LuxuryColorGrader
{
    public static void ProcessImage(string inputPath, string outputPath, float contrastBoost, float vibranceBoost, float warmR, float warmG, float warmB, float sharpness)
    {
        using (Bitmap srcBmp = new Bitmap(inputPath))
        {
            int width = srcBmp.Width;
            int height = srcBmp.Height;

            // Work on 32bpp ARGB for fast direct memory manipulation
            using (Bitmap dstBmp = new Bitmap(width, height, PixelFormat.Format32bppArgb))
            {
                using (Graphics g = Graphics.FromImage(dstBmp))
                {
                    g.DrawImage(srcBmp, 0, 0, width, height);
                }

                BitmapData bmpData = dstBmp.LockBits(
                    new Rectangle(0, 0, width, height),
                    ImageLockMode.ReadWrite,
                    PixelFormat.Format32bppArgb
                );

                int bytes = Math.Abs(bmpData.Stride) * height;
                byte[] rgbValues = new byte[bytes];
                byte[] resultValues = new byte[bytes];
                Marshal.Copy(bmpData.Scan0, rgbValues, 0, bytes);
                Array.Copy(rgbValues, resultValues, bytes);

                // Precompute tone curve (LUT) for contrast & brightness expansion
                byte[] lutR = new byte[256];
                byte[] lutG = new byte[256];
                byte[] lutB = new byte[256];

                for (int i = 0; i < 256; i++)
                {
                    double x = i / 255.0;
                    // S-curve contrast
                    double sCurve = x + contrastBoost * Math.Sin(2.0 * Math.PI * x) * 0.15;
                    // Ensure bounds
                    sCurve = Math.Max(0.0, Math.Min(1.0, sCurve));

                    // Warm color grading
                    double rVal = sCurve * 255.0 * warmR;
                    double gVal = sCurve * 255.0 * warmG;
                    double bVal = sCurve * 255.0 * warmB;

                    lutR[i] = (byte)Math.Max(0, Math.Min(255, (int)Math.Round(rVal)));
                    lutG[i] = (byte)Math.Max(0, Math.Min(255, (int)Math.Round(gVal)));
                    lutB[i] = (byte)Math.Max(0, Math.Min(255, (int)Math.Round(bVal)));
                }

                int stride = bmpData.Stride;

                // Step 1: Color Grading, Warmth, Contrast & Vibrance
                for (int y = 0; y < height; y++)
                {
                    int rowStart = y * stride;
                    for (int x = 0; x < width; x++)
                    {
                        int idx = rowStart + x * 4;
                        byte b = rgbValues[idx];
                        byte g = rgbValues[idx + 1];
                        byte r = rgbValues[idx + 2];
                        // a = rgbValues[idx + 3];

                        // Apply LUT
                        double rGraded = lutR[r];
                        double gGraded = lutG[g];
                        double bGraded = lutB[b];

                        // Vibrance calculation
                        double max = Math.Max(rGraded, Math.Max(gGraded, bGraded));
                        double min = Math.Min(rGraded, Math.Min(gGraded, bGraded));
                        double delta = max - min;
                        double lum = 0.299 * rGraded + 0.587 * gGraded + 0.114 * bGraded;

                        if (max > 0.0)
                        {
                            double sat = delta / max;
                            // Smart vibrance: boosts unsaturated pixels more
                            double boost = 1.0 + vibranceBoost * (1.0 - sat * 0.5);

                            rGraded = lum + (rGraded - lum) * boost;
                            gGraded = lum + (gGraded - lum) * boost;
                            bGraded = lum + (bGraded - lum) * boost;
                        }

                        resultValues[idx] = (byte)Math.Max(0, Math.Min(255, (int)Math.Round(bGraded)));
                        resultValues[idx + 1] = (byte)Math.Max(0, Math.Min(255, (int)Math.Round(gGraded)));
                        resultValues[idx + 2] = (byte)Math.Max(0, Math.Min(255, (int)Math.Round(rGraded)));
                    }
                }

                // Step 2: Unsharp Masking (Sharpening stone carving details and texture)
                if (sharpness > 0.01f)
                {
                    byte[] sharpValues = new byte[bytes];
                    Array.Copy(resultValues, sharpValues, bytes);

                    for (int y = 1; y < height - 1; y++)
                    {
                        int rowPrev = (y - 1) * stride;
                        int rowCurr = y * stride;
                        int rowNext = (y + 1) * stride;

                        for (int x = 1; x < width - 1; x++)
                        {
                            int idx = rowCurr + x * 4;
                            for (int c = 0; c < 3; c++) // B, G, R
                            {
                                int center = resultValues[idx + c];
                                int up = resultValues[rowPrev + x * 4 + c];
                                int down = resultValues[rowNext + x * 4 + c];
                                int left = resultValues[rowCurr + (x - 1) * 4 + c];
                                int right = resultValues[rowCurr + (x + 1) * 4 + c];

                                int laplacian = (4 * center) - (up + down + left + right);
                                int newVal = (int)Math.Round(center + sharpness * laplacian);

                                sharpValues[idx + c] = (byte)Math.Max(0, Math.Min(255, newVal));
                            }
                        }
                    }
                    Marshal.Copy(sharpValues, 0, bmpData.Scan0, bytes);
                }
                else
                {
                    Marshal.Copy(resultValues, 0, bmpData.Scan0, bytes);
                }

                dstBmp.UnlockBits(bmpData);

                // Save PNG format
                dstBmp.Save(outputPath, ImageFormat.Png);
            }
        }
    }
}
