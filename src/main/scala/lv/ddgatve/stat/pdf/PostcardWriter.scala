package lv.ddgatve.stat.pdf

import java.io.{ FileOutputStream, IOException }
import com.itextpdf.text.{ Document, PageSize, Rectangle }
import com.itextpdf.text.pdf.{ PdfContentByte, PdfImportedPage, PdfReader, PdfWriter }
import com.itextpdf.text.pdf.BaseFont

object PostcardWriter {

  /**
   * Utility to convert A4-format 1-page or 2-page PDF file to another A4 PDF - which has
   * every page reduced with a scale ratio to A5 or A6.
   * Currently only A6 size is supported; both A4 and all 4 copies of A6 are in portrait orientation.
   */
  def main(args: Array[String]): Unit = {
    //    if (args.size < 2) {
    //      Console.err.println("Usage: lv.ddgatve.stat.pdf.PostcardWriter a6 infile.pdf")
    //      System.exit(0)
    //    }

    val paperSize = "a6"
    val inFiles = List("warmup-2015-09-17-s.pdf",
        "warmup-2015-09-17-m.pdf",
      "warmup-2015-09-24-s.pdf", 
      "warmup-2015-09-24-m.pdf", 
      "warmup-2015-10-01-s.pdf", 
      "warmup-2015-10-01-m.pdf",
      "warmup-2015-10-15-s.pdf", 
      "warmup-2015-10-15-m.pdf")
    for (inFile <- inFiles) {
      //val inFile = args(1)
      val outFile = if (inFile.endsWith(".pdf")) {
        "src/main/resources/pdf/" + inFile.substring(0, inFile.length - 4) + "." + paperSize + ".pdf"
      } else {
        "src/main/resources/pdf/" + inFile + "." + paperSize + ".pdf"
      }

      val document = new Document()

      println("A4.getHeight() = " + PageSize.A4.getHeight)
      println("leftMargin = " + document.leftMargin)
      println("rightMargin = " + document.rightMargin)
      println("topMargin = " + document.topMargin)
      println("bottomMargin = " + document.bottomMargin)

      val reader = new PdfReader("../ddgatve-problems/" + inFile)
      val numPages = reader.getNumberOfPages
      println("numpages = " + numPages)
      //    val N = Math.ceil(numPages / 4f).toInt

      val writer = PdfWriter.getInstance(document, new FileOutputStream(outFile))
      document.setPageSize(PageSize.A4)
      document.setMargins(36f, 36f, 36f, 36f)
      document.open

      val cb: PdfContentByte = writer.getDirectContent
      //val scaleRatio = Math.sqrt(0.5f).toFloat
      val scaleRatio = 0.5f
      val halfHeight = PageSize.A4.getHeight() / 2f
      val halfWidth = PageSize.A4.getWidth() / 2f
      val pageSeq = List(List(1, 1, 1, 1), List(2, 2, 2, 2))

      pageSeq foreach { x =>
        {
          val pages = x map { pgNum =>
            if (pgNum <= numPages) { Some(writer.getImportedPage(reader, pgNum)) }
            else { None }
          }
          val horizOffset = List(0f, 0f, halfWidth, halfWidth)
          val vertOffset = List(0f, halfHeight, 0f, halfHeight)
          for (i <- 0 until 4) {
            if (i == 1) {
              //val cbBack = cb
              cb.saveState()
              cb.setLineWidth(0.2f);
              cb.setLineDash(3, 3, 0);
              cb.moveTo(halfWidth, 0);
              cb.lineTo(halfWidth, PageSize.A4.getHeight());
              cb.moveTo(0, halfHeight);
              cb.lineTo(PageSize.A4.getWidth(), halfHeight);
              cb.stroke();
              cb.restoreState()

            }

            pages(i) match {
              case Some(imported) => {
                cb.addTemplate(imported, scaleRatio, 0f, 0f, scaleRatio, horizOffset(i), vertOffset(i))
              }
              case None => {}
            }

          }

          //          val cb = writer.getDirectContent();
          //      cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA, BaseFont.WINANSI, false), 24);

          document.newPage
        }
      }
      document.close
    }
  }
}

