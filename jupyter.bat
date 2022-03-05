{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Photonic kernels"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {
    "scrolled": true
   },
   "outputs": [
    {
     "data": {
      "image/png": "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\n",
      "text/plain": [
       "<Figure size 432x288 with 1 Axes>"
      ]
     },
     "metadata": {
      "needs_background": "light"
     },
     "output_type": "display_data"
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Number of parameters for half chip: 16\n"
     ]
    }
   ],
   "source": [
    "from discopy.quantum.optics import ansatz, params_shape\n",
    "import numpy as np\n",
    "np.set_printoptions(precision=6)\n",
    "\n",
    "state = [1, 1, 0, 0, 0, 0]\n",
    "depth = 3\n",
    "\n",
    "width = len(state)\n",
    "n_photons = sum(state)\n",
    "\n",
    "n_params = np.prod(params_shape(width, depth))\n",
    "random_datapoint = lambda: np.random.uniform(0, 2, size=(n_params,))\n",
    "\n",
    "chip = lambda params: ansatz(width, depth, params)\n",
    "\n",
    "x = random_datapoint()\n",
    "(chip(x) >> chip(x).dagger()).draw(draw_type_labels=False)\n",
    "print(\"Number of parameters for half chip: {}\".format(n_params))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "[[  2.   3.   4.   5.   6.   7.]\n",
      " [  3.   6.  10.  15.  21.  28.]\n",
      " [  4.  10.  20.  35.  56.  84.]\n",
      " [  5.  15.  35.  70. 126. 210.]\n",
      " [  6.  21.  56. 126. 252. 462.]]\n"
     ]
    }
   ],
   "source": [
    "from scipy.special import binom\n",
    "from discopy.quantum.optics import occupation_numbers\n",
    "np.set_printoptions(suppress=True)\n",
    "\n",
    "scale = np.array([[binom(m + n - 1, n) for m in range(2, 8)] for n in range(1, 6)])\n",
    "print(scale)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Dimension of feature space: 21\n"
     ]
    }
   ],
   "source": [
    "dim = binom(width + n_photons - 1, n_photons)\n",
    "\n",
    "print(\"Dimension of feature space: {}\".format(int(dim)))"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "## Generate random data points"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Number of data points: 80\n"
     ]
    }
   ],
   "source": [
    "N = 80\n",
    "X = [random_datapoint() for _ in range(N)]\n",
    "\n",
    "print(\"Number of data points: {}\".format(N))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "metadata": {},
   "outputs": [],
   "source": [
    "# Add datapoints\n",
    "\n",
    "# a = 12\n",
    "# N = N + a\n",
    "# X = X + [random_datapoint() for _ in range(a)]"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "## Initialise bosonic and distinguishable kernels"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "metadata": {},
   "outputs": [],
   "source": [
    "def gram_matrix(kernel, x):\n",
    "    # Build a symmetric positive definite matrix\n",
    "    N = len(x)\n",
    "    gram = np.zeros((N, N))\n",
    "    for i in range(N):\n",
    "        for j in range(i + 1, N):\n",
    "            gram[i, j] = kernel(x[i], x[j])\n",
    "    return gram + np.diag(np.ones(N)) + np.transpose(gram)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Time to compute bosonic gram matrix: 48.7024986743927\n"
     ]
    }
   ],
   "source": [
    "import time\n",
    "\n",
    "q_state = state\n",
    "\n",
    "# Kernel with indistinguishable photons:\n",
    "\n",
    "q_kernel = lambda state: lambda x0, x1: (chip(x0) >> chip(x1).dagger()).indist_prob(state, state)\n",
    "start = time.time()\n",
    "q_gram = gram_matrix(q_kernel(q_state), X)\n",
    "print(\"Time to compute bosonic gram matrix: {}\".format(time.time() - start))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Time to compute distinguishable gram matrix: 59.43085312843323\n"
     ]
    }
   ],
   "source": [
    "# Kernel with distinguishable photons:\n",
    "\n",
    "c_state = state\n",
    "\n",
    "c_kernel = lambda state: lambda x0, x1: (chip(x0) >> chip(x1).dagger()).dist_prob(state, state)\n",
    "start = time.time()\n",
    "c_gram = gram_matrix(c_kernel(c_state), X)\n",
    "print(\"Time to compute distinguishable gram matrix: {}\".format(time.time() - start))"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "## Generate labels to maximise difference in prediction error bound"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Geometric difference: 1.403700246548799 \n",
      "Eigenvector: y = sqrt(q_gram)v = [ 0.601073  0.261565 -0.218388 ... -0.035405  0.026941  0.032917]\n"
     ]
    }
   ],
   "source": [
    "from scipy.linalg import inv, eigh\n",
    "\n",
    "regularization = 0.02\n",
    "\n",
    "def geometric_diff(k0, k1, reg=0.0):\n",
    "    S0, P0 = eigh(k0)\n",
    "    S1, P1 = eigh(k1)\n",
    "    sqrtk0 = P0.dot(np.diag(np.sqrt(np.absolute(S0)))).dot(np.transpose(P0))\n",
    "    sqrtk1 = P1.dot(np.diag(np.sqrt(np.absolute(S1)))).dot(np.transpose(P1))\n",
    "    center = P0.dot(np.diag((S0 + reg) ** -2)).dot(np.transpose(P0))\n",
    "    matrix = sqrtk1.dot(sqrtk0).dot(center).dot(sqrtk0).dot(sqrtk1)\n",
    "    S, V = eigh(matrix)\n",
    "    index = np.argmax(np.absolute(S))\n",
    "    return np.sqrt(np.absolute(S[index])), sqrtk1.dot(V[:, index])  \n",
    "\n",
    "g, y = geometric_diff(c_gram, q_gram, reg=regularization)\n",
    "print(\"Geometric difference: {} \\nEigenvector: y = sqrt(q_gram)v = {}\".format(g, y))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "s_Q = 0.9999999999999165 , s_C = 1.9703743821635755 , g = 1.403700246548799\n"
     ]
    }
   ],
   "source": [
    "def model_complexity(k, y, reg=False):\n",
    "    if not reg:\n",
    "        return np.transpose(y).dot(inv(k)).dot(y)\n",
    "    else:\n",
    "        S, P = eigh(k)\n",
    "        sqrtk = P.dot(np.diag(np.sqrt(np.absolute(S)))).dot(np.transpose(P))\n",
    "        matrix = sqrtk.dot(P).dot(np.diag((S + reg) ** -2)).dot(np.transpose(P)).dot(sqrtk)\n",
    "        return np.transpose(y).dot(matrix).dot(y)\n",
    "\n",
    "sQ = model_complexity(q_gram, y, reg=False)\n",
    "sC = model_complexity(c_gram, y, reg=regularization)\n",
    "assert np.isclose(sC, sQ * g ** 2)\n",
    "print(\"s_Q = {} , s_C = {} , g = {}\".format(sQ, sC, g))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Mean of y is -0.0034350247901296094 labels sum to 4.\n"
     ]
    }
   ],
   "source": [
    "y_labels = [1 if z > np.mean(y) else -1 for z in y]\n",
    "print(\"Mean of y is {} labels sum to {}.\".format(np.mean(y), sum(y_labels)))"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "## SVM comparison bosonic vs distinguishable"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 12,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "[LibSVM]\n",
      "Train accuracy: 0.9433962264150944\n",
      "\n",
      "Test accuracy: 0.8518518518518519\n",
      "\n",
      "Time elapsed: 41.953596115112305\n"
     ]
    }
   ],
   "source": [
    "from sklearn import svm\n",
    "from sklearn.metrics import classification_report, accuracy_score\n",
    "from sklearn.model_selection import train_test_split\n",
    "\n",
    "test_size = 1 / 3\n",
    "\n",
    "X_train, X_test, y_train, y_test = train_test_split(X, y_labels, test_size=test_size, random_state=115)\n",
    "\n",
    "classifier = svm.SVC(kernel='precomputed', verbose=True)\n",
    "\n",
    "start = time.time()\n",
    "q_gram_train = gram_matrix(q_kernel(q_state), X_train)\n",
    "classifier.fit(q_gram_train, y_train)\n",
    "q_acc_train = accuracy_score(y_train, classifier.predict(q_gram_train))\n",
    "print(\"\\nTrain accuracy: {}\".format(q_acc_train))\n",
    "\n",
    "q_gram_test = np.array([[q_kernel(q_state)(xi, xj) for xi in X_train] for xj in X_test])\n",
    "q_acc_test = accuracy_score(y_test, classifier.predict(q_gram_test))\n",
    "print(\"\\nTest accuracy: {}\".format(q_acc_test))\n",
    "print(\"\\nTime elapsed: {}\".format(time.time() - start))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 13,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "[LibSVM]\n",
      "Train accuracy: 0.9056603773584906\n",
      "\n",
      "Test accuracy: 0.8148148148148148\n",
      "\n",
      "Time elapsed: 49.22758197784424\n"
     ]
    }
   ],
   "source": [
    "start = time.time()\n",
    "c_gram_train = gram_matrix(c_kernel(c_state), X_train)\n",
    "classifier.fit(c_gram_train, y_train)\n",
    "c_acc_train = accuracy_score(y_train, classifier.predict(c_gram_train))\n",
    "print(\"\\nTrain accuracy: {}\".format(c_acc_train))\n",
    "\n",
    "c_gram_test = np.array([[c_kernel(c_state)(xi, xj) for xi in X_train] for xj in X_test])\n",
    "c_acc_test = accuracy_score(y_test, classifier.predict(c_gram_test))\n",
    "print(\"\\nTest accuracy: {}\".format(c_acc_test))\n",
    "print(\"\\nTime elapsed: {}\".format(time.time() - start))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 14,
   "metadata": {},
   "outputs": [],
   "source": [
    "# Partially distinguishable photons\n",
    "\n",
    "# S2 = lambda p: np.array([[1, p], [p, 1]])\n",
    "# S3 = lambda p: np.array([[1, p, 1], [p, 1, p], [1, p, 1]])\n",
    "\n",
    "# p_kernel = lambda dist, state: lambda x0, x1: (chip(x0) >> chip(x1).dagger()).pdist_prob(state, state, S=S2(dist))\n",
    "\n",
    "# for dist in np.arange(0, 1.1, 0.1):\n",
    "#     gram_train = np.array([[p_kernel(dist, state)(xi, xj) for xi in X_train] for xj in X_train])\n",
    "#     classifier.fit(gram_train, y_train)\n",
    "#     gram_test = np.array([[p_kernel(dist, state)(xi, xj) for xi in X_train] for xj in X_test])\n",
    "#     a_train = accuracy_score(y_train, classifier.predict(gram_train))\n",
    "#     a_test = accuracy_score(y_test, classifier.predict(gram_test))\n",
    "#     a = (1 - test_size) * a_train + test_size * a_test\n",
    "#     print(a_train, a_test, a)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "## Comparison with Gaussian kernels"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 15,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Best gamma is 0.4328761281083057 with geometric difference 2.642933441932638\n"
     ]
    }
   ],
   "source": [
    "# Compare using geometric difference\n",
    "\n",
    "from numpy.linalg import norm\n",
    "\n",
    "reg_param = 0.02\n",
    "\n",
    "gauss = lambda gamma: lambda x0, x1: np.exp(- gamma * norm(x0 - x1) ** 2)\n",
    "\n",
    "geos = {}\n",
    "for gamma in np.logspace(-4, 1, num=100):\n",
    "    g_gram = np.array([[gauss(gamma)(xi, xj) for xi in X] for xj in X])\n",
    "    geos.update({gamma : geometric_diff(g_gram, q_gram, reg=reg_param)[0]})\n",
    "    \n",
    "gamma_min = min(geos, key=geos.get)\n",
    "\n",
    "print(\"Best gamma is {} with geometric difference {}\".format(gamma_min, geos[gamma_min]))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 16,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "[LibSVM]\n",
      "Accuracy on train: 1.0\n",
      "Accuracy on test: 0.4074074074074074\n"
     ]
    }
   ],
   "source": [
    "gauss_train = np.array([[gauss(gamma_min)(xi, xj) for xi in X_train] for xj in X_train])\n",
    "classifier.fit(gauss_train, y_train)\n",
    "a_gauss_train = accuracy_score(y_train, classifier.predict(gauss_train))\n",
    "print(\"\\nAccuracy on train: {}\".format(a_gauss_train))\n",
    "\n",
    "gauss_test = np.array([[gauss(gamma_min)(xi, xj) for xi in X_train] for xj in X_test])\n",
    "a_gauss_test = accuracy_score(y_test, classifier.predict(gauss_test))\n",
    "print(\"Accuracy on test: {}\".format(a_gauss_test))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 17,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "GridSearchCV(cv=5, error_score='raise-deprecating',\n",
       "             estimator=SVC(C=1.0, cache_size=200, class_weight=None, coef0=0.0,\n",
       "                           decision_function_shape='ovr', degree=3,\n",
       "                           gamma='auto_deprecated', kernel='rbf', max_iter=-1,\n",
       "                           probability=False, random_state=None, shrinking=True,\n",
       "                           tol=0.001, verbose=False),\n",
       "             iid=False, n_jobs=None,\n",
       "             param_grid={'C': array([   0.01    ,    0.012649,    0.015999, ...,  625.055193,\n",
       "        790.604321, 1000.      ]),\n",
       "                         'gamma': array([   0.0001  ,    0.000118,    0.000138, ...,  722.080902,\n",
       "        849.753436, 1000.      ])},\n",
       "             pre_dispatch='2*n_jobs', refit=True, return_train_score=False,\n",
       "             scoring=None, verbose=0)"
      ]
     },
     "execution_count": 17,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "# Compare using GridSearch\n",
    "\n",
    "from sklearn.model_selection import GridSearchCV, StratifiedShuffleSplit\n",
    "\n",
    "C_range = np.logspace(-2, 3, num=50)\n",
    "gamma_range = np.logspace(-4, 3, num=100)\n",
    "param_grid = dict(gamma=gamma_range, C=C_range)\n",
    "grid = GridSearchCV(svm.SVC(), param_grid=param_grid, cv=5, iid=False)\n",
    "grid.fit(X_train, y_train)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 18,
   "metadata": {
    "scrolled": false
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "The best parameters are {'C': 390.6939937054621, 'gamma': 0.008111308307896872} with a score of 0.57\n",
      "Accuracy on train: 1.0\n",
      "Accuracy on test: 0.4074074074074074\n"
     ]
    }
   ],
   "source": [
    "print(\n",
    "    \"The best parameters are %s with a score of %0.2f\"\n",
    "    % (grid.best_params_, grid.best_score_)\n",
    ")\n",
    "a_g_train = accuracy_score(y_train, grid.predict(X_train))\n",
    "print(\"Accuracy on train: {}\".format(a_gauss_train))\n",
    "a_g_test = accuracy_score(y_test, grid.predict(X_test))\n",
    "print(\"Accuracy on test: {}\".format(a_gauss_test))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 19,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Best gamma is 0.4328761281083057\n"
     ]
    }
   ],
   "source": [
    "a_gauss_test = max(a_gauss_test, a_g_test)\n",
    "\n",
    "print(\"Best gamma is {}\".format(gamma_min))"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "## Store results"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 23,
   "metadata": {},
   "outputs": [],
   "source": [
    "import pickle \n",
    "\n",
    "dump_data = dict()\n",
    "dump_data.update({'X': X, 'y': y,'g': g, 'regularization': regularization, 'state': state})\n",
    "dump_data.update({'param_grid_gaussian': param_grid})\n",
    "filename = \"./gdatasets/datasetw{}d{}n{}N{}q{:.2f}c{:.2f}g{:.2f}\\\n",
    "            .pickle\".format(width, depth, sum(state), N, q_acc_test, c_acc_test, a_gauss_test)\n",
    "with open(filename, 'wb') as handle:\n",
    "    pickle.dump(dump_data, handle, protocol=pickle.HIGHEST_PROTOCOL)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "## Compare with different input states"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 21,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "[LibSVM]\n",
      "Accuracy on train: 0.7358490566037735\n",
      "Accuracy on test: 0.4074074074074074\n",
      "Overall accuracy: 0.6263685068716516\n"
     ]
    }
   ],
   "source": [
    "gram_train = gram_matrix(c_kernel([0, 0, 0, 0, 1, 1]), X_train)\n",
    "classifier.fit(gram_train, y_train)\n",
    "a_train = accuracy_score(y_train, classifier.predict(gram_train))\n",
    "print(\"\\nAccuracy on train: {}\".format(a_train))\n",
    "\n",
    "gram_test = np.array([[c_kernel([0, 0, 0, 0, 1, 1])(xi, xj) for xi in X_train] for xj in X_test])\n",
    "a_test = accuracy_score(y_test, classifier.predict(gram_test))\n",
    "print(\"Accuracy on test: {}\".format(a_test))\n",
    "print(\"Overall accuracy: {}\".format((1 - test_size) * a_train + test_size * a_test))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 22,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "[LibSVM]\n",
      "Accuracy on train: 1.0\n",
      "Accuracy on test: 0.7777777777777778\n",
      "Overall accuracy: 0.925925925925926\n"
     ]
    }
   ],
   "source": [
    "q2_gram_train = gram_matrix(q_kernel([1, 1, 1, 0, 0, 0]), X_train)\n",
    "classifier.fit(q2_gram_train, y_train)\n",
    "a_train = accuracy_score(y_train, classifier.predict(q2_gram_train))\n",
    "print(\"\\nAccuracy on train: {}\".format(a_train))\n",
    "\n",
    "q2_gram_test = np.array([[q_kernel([1, 1, 1, 0, 0, 0])(xi, xj) for xi in X_train] for xj in X_test])\n",
    "a_test = accuracy_score(y_test, classifier.predict(q2_gram_test))\n",
    "print(\"Accuracy on test: {}\".format(a_test))\n",
    "print(\"Overall accuracy: {}\".format((1 - test_size) * a_train + test_size * a_test))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.7.4"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 2
}
