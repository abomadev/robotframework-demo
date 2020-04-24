import pytesseract
import argparse

try:
    from PIL import Image
except ImportError:
    import Image

class TesseractOCR:

    def __init__(self, filename=None):
       self.filename = filename
       self._to_string()
        
    # --- private
    def _to_string(self):
        print(pytesseract.image_to_string(Image.open(self.filename)))


if __name__ == "__main__":
    """
    Command line usage:
    `python -m path.to.my_file -h` ==> show help
   
    """

    parser = argparse.ArgumentParser(description="My fancy script which does something.")
    parser.add_argument('--img-file', '-f', type=str, help="File containing and image of a word/s")

    args = parser.parse_args()
    
    run_once = TesseractOCR(filename=args.img_file)







# Simple image to string
# print(pytesseract.image_to_string(Image.open('../raw-data/hello-03.png')))