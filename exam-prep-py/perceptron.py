import util.util as util
import numpy as np
logger = util.create_logger(__name__)

if __name__== "__main__":
    logger.debug("starting main")
    num_passes = 2
    inputs = [[1.0, 1.0, 0.0],
              [1.0, 1.0, 1.0],
              [1.0, 0.0, -1.0],
              [1.0, 0.0, 1.0],
              [1.0, -1.0, 0.0],
              [1.0, -1.0, -1.0]]
    desired_outputs = [1.0, 1.0, 1.0, 0.0, 0.0, 0.0]
    weights = [1.0, 1.0, 1.0]
    eta = 1.0
    for i in range(num_passes):
        logger.debug("pass %d", i)
        for features, desired in zip(inputs,desired_outputs):
            output_val = 1.0 if np.dot(features, weights) >= 0.0 else 0.0
            logger.debug("desired %f", desired)
            logger.debug("actual %f", output_val)
            if output_val != desired:
                for j in range(len(weights)):
                    weights[j] += eta*(desired - output_val)*features[j]
            logger.debug("weights = %s", weights)