# k-Nearest Neighbors(KNN) Iris flower classification algorithm in VHDL

This project was developed for the Digital System Design course. It consists on classifying Iris flowers from the [Iris dataset](https://archive.ics.uci.edu/ml/datasets/Iris) based on 4 measurements (in cm): sepal length, sepal width, petal length and petal width to one of three possible classes (setosa, versicolor or virginica) whose design was proposed [here](https://kevinzakka.github.io/2016/07/13/k-nearest-neighbor/). The algorithm was implemented in hardware on the Basys3 FPGA in VHDL.

The measurements are real numbers represented in unsigned fixed-point format Q3.13 and the attributes are represented as 2-bit integers (00 – setosa, 01 – versicolor, 10 – virginica). The distance metric for the KNN algorithm is the square of the Euclidean distance and the system can be configure to produce results for k = 1, 3 or 5. The main goals of this project is to achieve the highest performance possible given the target device and technology.
