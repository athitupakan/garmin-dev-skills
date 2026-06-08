---
source: https://developer.garmin.com/connect-iq/core-topics/profiling/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Profiling.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Profiling Applications

The Connect IQ profiler captures time spent in total within a function and for the code within a function, and lets you examine the different call stacks profiled. The profiler is integrated into the simulator, and the devices will allow hardware profiling as well.

## Profiling from the Simulator

To launch the profiler from the Simulator, go to *File -> View Profiler*. You will see the following:

When you reach the point in your application you wish to profile, hit the “Start” button to begin data collection and hit “Stop” to finish. The data will then display in the profiler window:

The data collected is as follows:

| Name | Description | Notes |
| --- | --- | --- |
| Function | The function signature being called |  |
| Total Time (us) | The total time executing the function in microseconds. | This includes all calls during the capture duration. |
| Actual Time (us) | The time spent within the function in microseconds. | This includes all calls during the capture duration, but ignores time spent calling other functions. |
| Average Time (us) | The average amount of time per call spent in the function in microseconds | This is the average of the time to execute the function |
| Call Count | Number of times the function was called during the sample period |  |
| Call Stack | Indication of which functions invoked the sampled function |  |

If you only want to sample for a period, you can set a sample period in *Profiler -> Settings*. This will automatically stop the profiler after the specified period.

## Profiling on the Device

You can profile your app on device by compiling the app with the `-k` option. To do this in Visual Studio Code, edit the workspace settings edit the Monkey C Compiler Options:

After you do that, use *Monkey C: Build for Device* to create an executable. After you side load and run the program, a file named `.PRF` will be generated in the `GARMIN\APPS\LOGS` folder. You can load the PRF file into the simulator profile tool for analysis using the *Load* button in the profiler window.

## Best Practices

You can re-sort the sampled functions based on the total, actual, and average time spent as well as call count. Each can have value in identifying performance bottlenecks. For example, a function that has a low average time but is repeatedly called can sometimes cause performance bottlenecks. See what functions your application are spending the most time running and use that to focus your optimization efforts.
