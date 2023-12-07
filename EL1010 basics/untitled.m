ex = tf([1 1], [1 1 1])

s = tf('s')

tf1 = 1/s
tf2 = (s^2 + 1) / (s^4 + s)
tf3 = tf1*tf2

tf3
tf2
tf_feedback = feedback(tf3, tf2)
step(tf_feedback)
rlocus(tf_feedback)
figure(1)
bode(tf_feedback)
figure(2)
nyquist(tf_feedback)
figure(3)
nichols(tf_feedback)
