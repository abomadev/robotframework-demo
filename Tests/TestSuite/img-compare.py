import cv2 as cv
import numpy as np
from robot.api.deco import keyword


@keyword('Is Duplicate Image')
def is_duplicate_image(file1, file2):
    img1 = cv.imread("/Users/aboma/workspace/work/robotframework-demo/Tests/TestSuite/button2.png")
    img2 = cv.imread("/Users/aboma/workspace/work/robotframework-demo/Tests/TestSuite/dropdown.png")
    print("File1", img1)
    print("File2", img2)
    
    # check if the images are the same size
    if img1.shape == img2.shape:
        # Find the diff of the images
        bgr_diff = cv.subtract(img1, img2)
        
        # break the diff up into blue, green and red components
        b, g, r = cv.split(bgr_diff)
        
        if cv.countNonZero(b) == 0 and cv.countNonZero(g) == 0 and cv.countNonZero(r) == 0:
            return "Same"
    
    return "Different"
    
