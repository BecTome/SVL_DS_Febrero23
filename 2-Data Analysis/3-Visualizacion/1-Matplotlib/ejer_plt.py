import matplotlib.pyplot as plt
import numpy as np

theta = np.linspace(0, 2*np.pi, 100)
plt.plot(theta, 5 - 5*np.sin(theta), "r")
plt.savefig("img/cardioide_cart.jpeg")
plt.show()

plt.polar(theta, 5 - 5*np.sin(theta), "r")
plt.savefig("img/cardioide_polar.jpeg")
plt.show()