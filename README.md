# k-Nearest Neighbors(KNN) Iris flower classification algorithm in VHDL

This project was developed for the Digital System Design course. It consists on classifying Iris flowers from the [Iris dataset](https://archive.ics.uci.edu/ml/datasets/Iris) based on 4 measurements (in cm): sepal length, sepal width, petal length and petal width to one of three possible classes (setosa, versicolor or virginica) whose design was proposed [here](https://kevinzakka.github.io/2016/07/13/k-nearest-neighbor/). The algorithm was implemented in hardware on the Basys3 FPGA in VHDL.

The measurements are real numbers represented in unsigned fixed-point format Q3.13 and the attributes are represented as 2-bit integers (00 – setosa, 01 – versicolor, 10 – virginica). The distance metric for the KNN algorithm is the square of the Euclidean distance and the system can be configure to produce results for k = 1, 3 or 5. The main goals of this project is to achieve the highest performance possible given the target device and technology.

# Algorithm

The algorithm can be summarized into two steps:

1) For each instance of the training dataset, calculate the distance between the new instance (the one we are trying to classify) and the respective training instance, inserting the result into a list of size k in ascending order.

2) Determine the most common class (flower species) from the k-sized list obtained at the end of the first step.

# Implementation of the algorithm in hardware

For the first step, the calculation of the square of the Euclidean distance is made using 4 subtractors, 4 multipliers and 3 adders in a design with 3 pipelined stages in order to reduce the circuit's critical path. After obtaining the new distance, there are 5 comparators to compare this value with the 5 values from the ascending ordered list. The result of the comparators goes to a priority encoder, which determines if the new distance is going to the list (i.e. if the value is lower than at least one value of the ordered list) and how many right shifts is necessary in order to insert the new distance into the list. It is important to highlight that, in order to keep the coherency between the new distance and its respective class, there is another list for the classes which suffers the same right shifts as the distance list.

![Screenshot](images/hw_1.png)

For the second step, after obtaining the ordered list (of the classes), each class is compared with one of the three possible values (00, 01 or 10) by using three comparators, where each one is associated to a counter. Afterwards, the value of each counter is compared with the value of k (i.e. another 3 comparators are used), following this logic:

- For k = 00 (corresponds to k = 1), the most common class is the one with value 1, which corresponds to checking which counter is more than 0.

- For k = 01 (corresponds to k = 3), the most common class is the one with value 2 or 3, which corresponds to checking which counter is more than 1.

- For k = 10 (corresponds to k = 5), the most common class is the one with value 3, 4 or 5, which corresponds to checking which counter is more than 2.

The output of the comparators is connected to a priority encoder which finds which was the most common class.

![Screenshot](images/hw_2.png)

**NOTE: The code for this two steps can be found inside the src/ folder in the sorting.vhd file.**

## Parallelism


