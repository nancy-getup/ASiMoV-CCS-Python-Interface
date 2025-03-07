import csv
import re
import pandas as pd

# parse the output file to get the core number based on the file name 
def parse_core_number(file_path):
    """read the core number from the file path"""
    match = re.search(r"_(\d+)\.out$", file_path)
    return int(match.group(1)) if match else None

# parse the output file to get the results
def parse_output_file(file_path):
    core_number = parse_core_number(file_path)
    results = []
    with open(file_path, 'r') as file:
        current_params = {}
        for line in file:
            # parse the parameters, including dt, cps, and num_steps, and save them in the current_params
            if "Running with" in line:
                params = re.search(r"dt=(\d+\.?\d*), cps=(\d+), num_steps=(\d+)", line)
                if params:
                    if current_params:
                        results.append(current_params)
                    current_params = {
                        'Core': core_number,
                        'dt': float(params.group(1)),
                        'cps': int(params.group(2)),
                        'num_steps': int(params.group(3)),
                        'L2_Error': [],
                        'Linf_Error': [],
                        'Init_time': [],
                        'Elapsed_time': []
                    }
            elif current_params:
                # parse the error and time information
                if 'L2 Error:' in line:
                    l2_error = re.search(r"L2 Error: \[([^\]]+)\]", line)
                    if l2_error:
                        current_params['L2_Error'].append([float(num) for num in l2_error.group(1).split(',')])
                
                if 'Linf Error:' in line:
                    linf_error = re.search(r"Linf Error: \[([^\]]+)\]", line)
                    if linf_error:
                        current_params['Linf_Error'].append([float(num) for num in linf_error.group(1).split(',')])

                if 'Init time:' in line:
                    init_time_match = re.search(r"Init time: (\d+\.\d+)", line)
                    if init_time_match:
                        current_params['Init_time'].append(float(init_time_match.group(1)))

                if 'Elapsed time:' in line:
                    elapsed_time_match = re.search(r"Elapsed time: (\d+\.\d+)", line)
                    if elapsed_time_match:
                        current_params['Elapsed_time'].append(float(elapsed_time_match.group(1)))

        if current_params:
            results.append(current_params)

    return results

# save the results to a CSV file
def save_results_to_csv(results, output_file):
    with open(output_file, 'w', newline='') as csvfile:
        # define the field names and write the header
        fieldnames = ['Core', 'dt', 'cps', 'num_steps', 'L2_Error_1', 'L2_Error_2', 'L2_Error_3', 'Linf_Error_1', 'Linf_Error_2', 'Linf_Error_3', 'Init_time', 'Elapsed_time']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()

        # write the results to the CSV file 
        for data in results:
            for i in range(len(data['L2_Error'])):
                row = {
                    'Core': data['Core'],
                    'dt': data['dt'],
                    'cps': data['cps'],
                    'num_steps': data['num_steps'],
                    'L2_Error_1': data['L2_Error'][i][0],
                    'L2_Error_2': data['L2_Error'][i][1],
                    'L2_Error_3': data['L2_Error'][i][2],
                    'Linf_Error_1': data['Linf_Error'][i][0],
                    'Linf_Error_2': data['Linf_Error'][i][1],
                    'Linf_Error_3': data['Linf_Error'][i][2],
                    'Init_time': data['Init_time'][i] if i < len(data['Init_time']) else None,
                    'Elapsed_time': data['Elapsed_time'][i] if i < len(data['Elapsed_time']) else None
                }
                writer.writerow(row)

# read the output file
file_path = '../../summary_output_32.out' # this value should be changed to the path of the output file for each core number
output_file = 'results.csv'  # the output file gerenated in the same directory

results = parse_output_file(file_path)
save_results_to_csv(results, output_file)
print(f"Results have been written to {output_file}")

# read the CSV file
input_csv_path = './data/results.csv'
df = pd.read_csv(input_csv_path)

# group by the core number, dt, cps, and num_steps, and then calculate the average
grouped_df = df.groupby(['Core', 'dt', 'cps', 'num_steps']).mean().reset_index()

# write in the average results to a new CSV file
output_csv_path = 'results_avg.csv'
grouped_df.to_csv(output_csv_path, index=False)
print(f"Average results have been written to {output_csv_path}")
