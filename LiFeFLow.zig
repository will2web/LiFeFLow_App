const TimeInfo = struct {
    //I'd like to convert these to u32 when possible
    planned_start_time: i64,
    planned_end_time: i64,
    actual_start_time: i64,
    actual_end_time: i64,
};

const Block = struct {
    times: TimeInfo,
};

const Core_Item = struct {
    times: TimeInfo,
};

//SAVE data to file in JSON format (much like Trello does)

const std = @import("std");
const debug_print = std.debug.print;
pub fn main() !void {
    const Lets_Get_It = Block{
        .times = TimeInfo{
            .planned_start_time = 1746795600,
            .planned_end_time = 1746806400,
            .actual_start_time = 0,
            .actual_end_time = 0,
        },
    };

    std.debug.print("Planned Start Time: {}\n", .{Lets_Get_It.times.planned_start_time});
    try printconvertedTime(Lets_Get_It.times.planned_start_time);

    std.debug.print("Planned End Time: {}\n", .{Lets_Get_It.times.planned_end_time});
    try printconvertedTime(Lets_Get_It.times.planned_end_time);

    std.debug.print("Actual Start Time: {}\n", .{Lets_Get_It.times.actual_start_time});
    std.debug.print("Actual End Time: {}\n", .{Lets_Get_It.times.actual_end_time});

    //const current_Time = std.time.Instant.now();
    //debug_print("Current Time is {any}\n", .{current_Time});

    try printconvertedTime(std.time.timestamp());

    //  debug_print("std.time.epoch.Year {any}\n", .{std.time.epoch.Year});
}

const DaysPerMonth = [_]u8{ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

fn isLeapYear(year: i32) bool {
    return (@rem(year, 4) == 0 and @rem(year, 100) != 0) or (@rem(year, 400) == 0);
}

fn daysInMonth(month: usize, year: i32) u8 {
    if (month == 1 and isLeapYear(year)) return 29;
    return DaysPerMonth[month];
}

fn printconvertedTime(time_In_Seconds: i64) !void {
    const stdout = std.io.getStdOut().writer();
    //const timestamp: i64 = std.time.timestamp(); // seconds since 1970-01-01

    //    var remaining = timestamp;
    var remaining = time_In_Seconds;

    var year: i32 = 1970;
    while (true) {
        const days_in_year: i64 = if (isLeapYear(year)) @as(i64, 366) else @as(i64, 365);
        const seconds_in_year = days_in_year * 86400;
        if (remaining >= seconds_in_year) {
            remaining -= seconds_in_year;
            year += 1;
        } else break;
    }

    var month: usize = 0;
    while (month < 12) {
        const dim = @as(i64, daysInMonth(month, year)) * 86400;
        if (remaining >= dim) {
            remaining -= dim;
            month += 1;
        } else break;
    }

    const day = @divTrunc(remaining, 86400) + 1;
    remaining = @rem(remaining, 86400);

    var hour = @divTrunc(remaining, 3600);
    hour -= 7; //convert to my (California) time zone
    remaining = @rem(remaining, 3600);
    const minute = @divTrunc(remaining, 60);
    const second = @rem(remaining, 60);

    const is_pm = hour >= 12;
    const hour12 = blk: {
        const h = @mod(hour, 12);
        break :blk if (h == 0) 12 else h;
    };
    const suffix = if (is_pm) "PM" else "AM";

    try stdout.print(
        "Formatted Time: {d}-{d}-{d} {d}:{d}:{d} {s}\n",
        //"Formatted Time: {d}-{d}-{d} {d}:{d}:{d} {s}\n",
        //
        .{ month + 1, day, year, hour12, minute, second, suffix },
    );

    try stdout.print("Time: {d}-{d}-{d} {d}:{d}:{d} {s}\n", .{ month + 1, day, year, hour12, minute, second, suffix });
}

//check out std.time.epoch

//At the end of the day, even in Trello I am simply writing text in a text box

//What I don't like about Trello:

//BELOW Is just an example of how to save to JSON
// const weightStruct = struct { Weight0: f32, Weight1: f32, Weight2: f32 };
// const json_weights = weightStruct{
//     .Weight0 = weights[0],
//     .Weight1 = weights[1],
//     .Weight2 = weights[2],
// };

// var json_buffer: [1024]u8 = undefined;
// var json_fba = std.heap.FixedBufferAllocator.init(&json_buffer);
// var json_writer = std.ArrayList(u8).init(json_fba.allocator());
// try std.json.stringify(json_weights, .{}, json_writer.writer());

// std.debug.print("Type of json_writer is {any}\n", .{@TypeOf(json_writer)});
// std.debug.print("Type of json_writer.writer() is {any}\n", .{@TypeOf(json_writer.writer())});
// std.debug.print("Type of json_writer.items is {any}\n", .{@TypeOf(json_writer.items)});

// const weightsFile = try std.fs.cwd().createFile("weights.json", .{});
// try weightsFile.writeAll(json_writer.items);
// defer weightsFile.close();
//ABOVE Is just an example of how to save to JSON

fn MYconvertTime(time_In_Seconds: i64) !void {
    //var seconds_Elapsed = seconds;
    const seconds_In_Year = 365 * 24 * 60 * 60;
    const seconds_In_Leap_Year = seconds_In_Year + (24 * 60 * 60);
    var present_Year: i16 = 1970;
    while (time_In_Seconds > seconds_In_Year) {
        if (@mod(present_Year, 400) == 0) {
            time_In_Seconds -= seconds_In_Leap_Year;
        } else if (@mod(present_Year, 100) == 0) {
            time_In_Seconds -= seconds_In_Year;
        } else if (@mod(present_Year, 4) == 0) {
            time_In_Seconds -= seconds_In_Leap_Year;
        } else {
            time_In_Seconds -= seconds_In_Year;
        }
        present_Year += 1;
    }

    debug_print("present_Year: {any}\n", .{present_Year});
}
fn oldCode() !void {
    debug_print("\n", .{});
    const real_Months = (55 * 12) + 4;
    debug_print("real_Months since UTC 1970-01-01 {any}\n", .{real_Months});

    var seconds_Elapsed = std.time.timestamp();
    const seconds_In_Year = 365 * 24 * 60 * 60;
    const seconds_In_Leap_Year = seconds_In_Year + (24 * 60 * 60);
    var present_Year: i16 = 1970;
    while (seconds_Elapsed > seconds_In_Year) {
        if (@mod(present_Year, 400) == 0) {
            seconds_Elapsed -= seconds_In_Leap_Year;
        } else if (@mod(present_Year, 100) == 0) {
            seconds_Elapsed -= seconds_In_Year;
        } else if (@mod(present_Year, 4) == 0) {
            seconds_Elapsed -= seconds_In_Leap_Year;
        } else {
            seconds_Elapsed -= seconds_In_Year;
        }
        present_Year += 1;
    }

    const seconds = std.time.timestamp();
    const minutes = @divTrunc(seconds, 60);
    const hours = @divTrunc(minutes, 60);
    const days = @divTrunc(hours, 24);
    const months = @divTrunc(days, 30); //approximate, need more involved function
    const years = @divTrunc(months, 12);

    debug_print("\n", .{});
    debug_print("seconds since UTC 1970-01-01 {any}\n", .{seconds});
    debug_print("minutes since UTC 1970-01-01 {any}\n", .{minutes});
    debug_print("hours since UTC 1970-01-01 {any}\n", .{hours});
    debug_print("days since UTC 1970-01-01 {any}\n", .{days});
    debug_print("months since UTC 1970-01-01 {any}\n", .{months});
    debug_print("years since UTC 1970-01-01 {any}\n", .{years});

    debug_print("present_Year: {any}\n", .{present_Year});

    const current_Second = @mod(seconds, 60);
    const current_Minute = @mod(minutes, 60);
    const current_Hour = @mod(hours, 24);
    const current_Day = @mod(days, 30);
    const current_Month = @mod(months, 12);
    const current_Year = years;
    // const current_Minutes = time_Stamp - (hours * 60 * 60);
    debug_print("\n", .{});
    debug_print("current_Second: {any}\n", .{current_Second});
    debug_print("current_Minute: {any}\n", .{current_Minute});
    debug_print("current_Hour: {any}\n", .{current_Hour});
    debug_print("current_Day: {any}\n", .{current_Day});
    debug_print("current_Month: {any}\n", .{current_Month});
    debug_print("current_Year: {any}\n", .{current_Year});
    debug_print("\n", .{});
}
