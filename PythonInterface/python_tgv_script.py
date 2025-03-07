import python_tgv2d_f2py_module 
import argparse

# parse the input arguments from the command line
parser = argparse.ArgumentParser(description='Process TGV2D parameters.')
parser.add_argument('--cps', type=int, default=32, help='Cells per side')
parser.add_argument('--dt', type=float, default=0.05, help='Time step size')
parser.add_argument('--num_steps', type=int, default=10, help='Number of steps')
args = parser.parse_args()

# Assign the values of the input arguments to the corresponding variables
python_case_name = "TaylorGreenVortex2D"
cps = args.cps
dt = args.dt
num_steps = args.num_steps

# check if the module is available
try:
  python_tgv2d_f2py_module
except ImportError:
  print("Error: Module python_tgv2d_f2py_module not found.")
  exit(1)

# check if the values of each parameter are valid
if cps <= 0:
  print("Error: Invalid value for --cps. Must be greater than 0.")
  exit(1)
if dt <= 0:
  print("Error: Invalid value for --dt. Must be greater than 0.")
  exit(1)
if num_steps <= 0:
  print("Error: Invalid value for --num_steps. Must be greater than 0.")
  exit(1)

# execute the TGV2D simulation and get the error values
error_L2, error_Linf  = python_tgv2d_f2py_module.python_call_tgv2d.process_tgv2d(dt, num_steps, python_case_name, cps)
error_L2 = error_L2[0:3]
error_Linf = error_Linf[0:3]
print("L2 Error: ", error_L2.tolist())
print("Linf Error: ", error_Linf.tolist())