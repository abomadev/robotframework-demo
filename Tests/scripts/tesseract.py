import argparse
import sys
# https://pypi.org/project/pytesseract/

try:
    import pytesseract
    from PIL import Image
except ImportError:
    import Image

class TesseractOCR:

    def __init__(self, img_file=None, output_file=None):
       self.img_file = img_file
       self.output = self._to_string()
       print(self.output)
       if output_file:
            self.save_to_file(output_file)
        
    # --- private
    def _to_string(self):
        return pytesseract.image_to_string(Image.open(self.img_file))
    
    def save_to_file(self, output_file):
        f = open(output_file, "w")
        f.write(self.output)
        f.close()


if __name__ == "__main__":
    """
    Command line usage:
    `python -m path.to.my_file -h` ==> show help
   
    """

    parser = argparse.ArgumentParser(description="My fancy script which does something.")
    parser.add_argument('-i','--img-file', type=str, required=True, help="File containing and image of a word/s")
    parser.add_argument('-o','--output-file', type=str, help="File containing and image of a word/s")

    args = parser.parse_args()
    run_once = TesseractOCR(img_file=args.img_file.strip(), output_file=args.output_file.strip())






# Simple image to string
# print(pytesseract.image_to_string(Image.open('../raw-data/hello-03.png')))