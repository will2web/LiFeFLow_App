//BELOW is just a struct scaffolding for the above noted fields
const Node = struct {
    value: i8,
    //Should next node pointer point to a node, or another pointer?
    next_node_pointer: ?*Node,
};

//SAVE data to file in JSON format (much like Trello does)

const std = @import("std");
const debug_print = std.debug.print;
pub fn main() !void {

    //const current_Time = std.time.Instant.now();
    //debug_print("Current Time is {any}\n", .{current_Time});

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

    debug_print("\n", .{});
    const real_Months = (55 * 12) + 4;
    debug_print("real_Months since UTC 1970-01-01 {any}\n", .{real_Months});
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

    //  debug_print("std.time.epoch.Year {any}\n", .{std.time.epoch.Year});
}
//check out std.time.epoch

//At the end of the day, even in Trello I am simply writing text in a text box

//What I don't like about Trello:

//FIELDS
//Time: Proposed Block Start        Proposed Block End
//Time: Actual Block Start          Actual Block End
//Time: Proposed Item Start         Proposed Item End
//Time: Actual Item Start           Actual Item End

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
