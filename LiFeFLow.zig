const std = @import("std");
const debug_print = std.debug.print;

pub fn main() !void {
    //SAVE data to file in JSON format (much like Trello does)

    //At the end of the day, even in Trello I am simply writing text in a text box
    //

    //BELOW Is just so I haveAn example of how to save to JSON
    const weightStruct = struct { Weight0: f32, Weight1: f32, Weight2: f32 };
    const json_weights = weightStruct{
        .Weight0 = weights[0],
        .Weight1 = weights[1],
        .Weight2 = weights[2],
    };

    var json_buffer: [1024]u8 = undefined;
    var json_fba = std.heap.FixedBufferAllocator.init(&json_buffer);
    var json_writer = std.ArrayList(u8).init(json_fba.allocator());
    try std.json.stringify(json_weights, .{}, json_writer.writer());

    std.debug.print("Type of json_writer is {any}\n", .{@TypeOf(json_writer)});
    std.debug.print("Type of json_writer.writer() is {any}\n", .{@TypeOf(json_writer.writer())});
    std.debug.print("Type of json_writer.items is {any}\n", .{@TypeOf(json_writer.items)});

    const weightsFile = try std.fs.cwd().createFile("weights.json", .{});
    try weightsFile.writeAll(json_writer.items);
    defer weightsFile.close();
}
