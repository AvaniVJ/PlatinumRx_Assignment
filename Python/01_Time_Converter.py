# Convert minutes to hours and minutes

try:
    minutes = int(input("Enter minutes: "))

    if minutes < 0:
        print("Minutes cannot be negative")
    else:
        hours = minutes // 60
        remaining_minutes = minutes % 60

        if hours == 0:
            print(f"{remaining_minutes} minutes")
        elif remaining_minutes == 0:
            print(f"{hours} hr" if hours == 1 else f"{hours} hrs")
        else:
            hour_label = "hr" if hours == 1 else "hrs"
            print(f"{hours} {hour_label} {remaining_minutes} minutes")

except ValueError:
    print("Invalid input. Please enter an integer.")
