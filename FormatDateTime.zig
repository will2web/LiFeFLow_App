const std = @import("std");

const DaysPerMonth = [_]u8{ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

fn isLeapYear(year: i32) bool {
    return (@rem(year, 4) == 0 and @rem(year, 100) != 0) or (@rem(year, 400) == 0);
}

fn daysInMonth(month: usize, year: i32) u8 {
    if (month == 1 and isLeapYear(year)) return 29;
    return DaysPerMonth[month];
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const timestamp: i64 = std.time.timestamp(); // seconds since 1970-01-01

    var remaining = timestamp;

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

    const hour = @divTrunc(remaining, 3600);
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
        "Formatted Time: {d:02}-{d:02}-{d:04} {d:02}:{d:02}:{d:02} {s}\n",
        .{ month + 1, day, year, hour12, minute, second, suffix },
    );
}
