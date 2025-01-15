# Phase Diagram Prediction Using Neural Networks

This repository contains a Python script and Matlab scripts for generating training data and predicting phase boundaries in binary phase diagrams using neural networks. The model is trained on data containing composition, temperature, and pressure, and can predict phase boundaries at new, unseen pressures to an extent.

## Features
- **Neural Network Model**: Implements a fully connected neural network for binary classification of phase boundaries.
- **Pressure-Aware Predictions**: Trains on multiple pressures to generalize predictions for unseen pressures.
- **Visualization**: Generates contour plots of phase boundaries for given pressures.
- **Scalable Design**: Easy to extend to larger datasets or multi-class classification problems.

## Requirements
- Python 3.7+
- TensorFlow
- NumPy
- Pandas
- Matplotlib
- Scikit-learn

Install dependencies using:
```bash
pip install tensorflow numpy pandas matplotlib scikit-learn
