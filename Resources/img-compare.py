import cv2

class ImageCompare:
    ROBOT_LIBRARY_SCOPE = 'TEST'

    def is_duplicate_image(self, file1, file2):
        
        img1 = cv2.imread(file1)
        img2 = cv2.imread(file2)
        
        # check if the images are the same size
        if img1.shape != img2.shape:
            return False
        
        # Find the diff of the images
        bgr_diff = cv2.subtract(img1, img2)
        
        # break the diff up into blue, green and red components
        b, g, r = cv2.split(bgr_diff)
        
        if cv2.countNonZero(b) == 0 and cv2.countNonZero(g) == 0 and cv2.countNonZero(r) == 0:
            return True
        
        return False
