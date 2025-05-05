const std = @import("std");
const debug_print = std.debug.print;

//BELOW is just a struct scaffolding for the above noted fields
const Node = struct {
    value: i8,
    //Should next node pointer point to a node, or another pointer?
    next_node_pointer: ?*Node,
};

pub fn main() !void {
    //SAVE data to file in JSON format (much like Trello does)

    const current_Time = std.time.Instant.now();
    const time_Stamp = std.time.timestamp();

    // Format the current time
    // const format = "%Y-%m-%d %H:%M:%S %Z";
    // var buffer: [64]u8 = undefined;
    //const formatted = try std.time. (current_Time, format, &buffer);
    //std.debug.print("Formatted future time: {s}\n", .{formatted});

    debug_print("Current Time is {any}\n", .{current_Time});
    debug_print("Time stamp is {any}\n", .{time_Stamp});

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
}
