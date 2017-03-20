require 'pry'

def do_linear_regression(samples:, alpha:, theta0:, theta1:, precision:, delay: 0)
  m = samples.size
  max_error = 1.0 / (10 ** precision)
  iterations = 0
  while true do
    puts "Doing theta0: #{theta0} and theta1: #{theta1} for iteration #{iterations + 1}"
    temp0 = theta0 - alpha * (1.0 / m) * cost_derivative_theta0(theta0, theta1, samples)
    temp1 = theta1 - alpha * (1.0 / m) * cost_derivative_theta1(theta0, theta1, samples)
    if (temp0 - theta0).abs < max_error && (temp1 - theta1).abs < max_error
      break
    else
      theta0 = temp0
      theta1 = temp1
    end
    iterations += 1
    sleep delay
  end
  puts "Found proper approximate for the requested precision after #{iterations} iterations:"
  puts "theta0: #{theta0.round(precision - 2)}"
  puts "theta1: #{theta1.round(precision - 2)}"
end

def cost_derivative_theta0(theta0, theta1, samples)
  samples.map { |sample| h(theta0, theta1, sample[0]) - sample[1] }.inject(0, :+)
end

def cost_derivative_theta1(theta0, theta1, samples)
  samples.map { |sample| (h(theta0, theta1, sample[0]) - sample[1]) * sample.first }.inject(0, :+)
end

def h(theta0, theta1, x)
  theta0 + theta1 * x
end

samples = [
  [1, 0.5],
  [2, 1],
  [4, 2],
  [0, 0]
]

# samples: training set
# alpha: learning rate
# theta0: initial offset
# theta1: initial slope
# precision: allowed error
# delay: seconds to slow-mo between each iteration

do_linear_regression(samples: samples, alpha: 0.1, theta0: 2.0, theta1: 1.0, precision: 4)
