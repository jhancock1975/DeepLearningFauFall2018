import numpy as np

#  convert 2-d list to 1-d list for dot product
# https://stackoverflow.com/posts/952952/revisions
# edited by Stack Overlfow user Mona Jalal 2017/6/14
# original answer by Stack Overflow user Alex Martelli 2009/07/04
def flatten(l):
  return [curr for sub_lst in l for curr in sub_lst]

# TODO find a more Pythonic way to 
# iterate over img_arr - perhaps use
# slicing
def filter_func(img_arr,filter_arr):
  """
  apply convolution filter filter_arr to img_arr with
  stride 1
  @param img_arr: input image
  @param filter_arr: convolutional filter
  @return: new array with convolutional filter applied
  """
  result=[]
  max_index = len(img_arr) - len(filter_arr)+1
  for i in range(max_index):
    for j in range(max_index):
       sub_arr=[]
       for k in range(i,i+len(filter_arr)):
         sub_sub_arr=[]
         for l in range(j,j+len(filter_arr)):
           sub_sub_arr.append(img_arr[k][l])
         sub_arr.append(sub_sub_arr)
       print(sub_arr)
       result.append(np.dot(flatten(sub_arr),flatten(filter_arr)))
  return np.reshape(result,(max_index,max_index))


def max_pooling(img_arr, pool_size):
  """
  partition img_arr into pool_size x pool_size
  sub-arrays and return a pool_size x pool_size
  array where the i,j_th entry in the array we
  return has the maximum value of the 
  pool_size x pool_size sub array
  @param img_arr: input array
  @param pool_size: size of sub partitions
  @return: pool_size x pool_size array that
  results from applying maximum pooling
  algorithm to input array
  """
  result=[]
  for i in range(0,len(img_arr), pool_size):
    for j in range(0, len(img_arr), pool_size):
      print('pooling i=%d,j=%d'%(i,j))
      print('pooling %s ' % img_arr[i:i+pool_size][j:j+pool_size])
      print(max(flatten(img_arr[i:i+pool_size][j:j+pool_size])))

  assert False  
if __name__ == '__main__':
# do example from slide to check correctness  
  img_arr = \
   [[1,0,0,0,0,1],
    [0,1,0,0,1,0],
    [0,0,1,1,0,0],
    [1,0,0,0,1,0],
    [0,1,0,0,1,0],
    [0,0,1,0,1,0]]

  filter_arr = \
  [[1,-1,-1],
   [-1,1,-1],
   [-1,-1,1]]

  print(filter_func(img_arr,filter_arr))
# do answer to question 3, first part
  img_arr=\
   [[4,3,4,0,4],
    [3,5,5,1,6],
    [2,7,3,1,5],
    [6,5,4,0,6],
    [6,3,5,0,4]]

  filter_arr=\
  [[1,-1],
   [1,-1]]
 
  filtered_arr = filter_func(img_arr,filter_arr) 
  print(filtered_arr)
  pooled_arr = max_pooling(filtered_arr, 2)
  print(pooled_arr)

