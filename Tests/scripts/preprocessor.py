import argparse
import sys
# https://pypi.org/project/pytesseract/
# https://medium.com/@jaafarbenabderrazak.info/ocr-with-tesseract-opencv-and-python-d2c4ec097866
import cv2
import numpy as np
import shutil


class Preprocessor:
    
    def __init__(self, img_file=None, filters=None, output_file=None):
        
        self.image = cv2.imread(img_file)
        
        for filter in filters.split():
            print(filter)
            self.image = self.preprocess(filter)
        
        cv2.imwrite(output_file,self.image)

    def preprocess(self, filter):
        if filter == 'grayscale':
            return self.get_grayscale()
        elif filter == 'remove_noise':
            return self.remove_noise()
        elif filter == 'thresholding':
            return self.thresholding()
        elif filter == 'dilate':
            return self.dilate()
        elif filter == 'erode':
            return self.erode()
        elif filter == 'opening':
            return self.opening()
        elif filter == 'canny':
            return self.canny()
        elif filter == 'deskew':
            return self.deskew()
        # elif filter == 'match_template':
        #     return self.match_template(template)
        else: 
            print("Invalid filter")
            return "ERROR"


    # get grayscale image
    def get_grayscale(self):
        return cv2.cvtColor(self.image, cv2.COLOR_BGR2GRAY)
        
    # noise removal
    def remove_noise(self):
        return cv2.medianBlur(self.image,5)
    
    #thresholding
    def thresholding(self):
        # threshold the image, setting all foreground pixels to
        # 255 and all background pixels to 0
        return cv2.threshold(gray, 0, 255, cv2.THRESH_BINARY | cv2.THRESH_OTSU)[1]

    #dilation
    def dilate(self):
        kernel = np.ones((5,5),np.uint8)
        return cv2.dilate(self.image, kernel, iterations = 1)
        
    #erosion
    def erode(self):
        kernel = np.ones((5,5),np.uint8)
        return cv2.erode(self.image, kernel, iterations = 1)

    #opening - erosion followed by dilation
    def opening(self):
        kernel = np.ones((5,5),np.uint8)
        return cv2.morphologyEx(self.image, cv2.MORPH_OPEN, kernel)

    #canny edge detection
    def canny(self):
        return cv2.Canny(self.image, 100, 200)

    #skew correction
    def deskew(self):
        gray = cv2.cvtColor(self.image, cv2.COLOR_BGR2GRAY)
        gray = cv2.bitwise_not(gray)
        thresh = cv2.threshold(gray, 0, 255,
            cv2.THRESH_BINARY | cv2.THRESH_OTSU)[1]
        coords = np.column_stack(np.where(thresh > 0))
        angle = cv2.minAreaRect(coords)[-1]
        if angle < -45:
            angle = -(90 + angle)
        else:
            angle = -angle
        (h, w) = self.image.shape[:2]
        center = (w // 2, h // 2)
        M = cv2.getRotationMatrix2D(center, angle, 1.0)
        rotated = cv2.warpAffine(self.image, M, (w, h),
            flags=cv2.INTER_CUBIC, borderMode=cv2.BORDER_REPLICATE)    
        return rotated

    #template matching
    def match_template(self, image, template):
        return cv2.matchTemplate(self.image, template, cv2.TM_CCOEFF_NORMED)

if __name__ == "__main__":
    """
    Command line usage:
    `python -m path.to.my_file -h` ==> show help
   
    """

    parser = argparse.ArgumentParser(description="My fancy script which does something.")
    parser.add_argument('-i','--img-file', type=str, required=True, help="File containing and image of a word/s")
    parser.add_argument('-f','--filters', type=str,required=True, help="File containing and image of a word/s")
    parser.add_argument('-o','--output-file', type=str, help="File containing and image of a word/s")

    args = parser.parse_args()
    run_once = Preprocessor(img_file=args.img_file.strip(), filters=args.filters, output_file=args.output_file.strip())






# Simple image to string
# print(pytesseract.image_to_string(Image.open('../raw-data/hello-03.png')))