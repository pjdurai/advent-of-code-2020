use Test;

# Problem 1
enum Direction <East North West South>;

sub move(%acc,$direction, $movement) {
    given $direction {
        when East { %acc{"X"} = %acc{"X"} + $movement}
        when West { %acc{"X"} = %acc{"X"} - $movement}
        when North { %acc{"Y"} = %acc{"Y"} + $movement}
        when South { %acc{"Y"} = %acc{"Y"} - $movement}
    }
    %acc;
}

multi sub turn($direction, "L", $angle) {
    Direction(($direction + ($angle/90)) % 4);
}
multi sub turn($direction, "R", $angle) {
    Direction(($direction - ($angle/90)) % 4);
}

sub get-direction($code){
    do given $code {
        when "E" {East}
        when "W" {West}
        when "N" {North}
        when "S" {South}
    }
}

sub solve(@input) {
    my %final = reduce sub (%acc, $line){
        if $line ~~ /(\w)(\d+)/ {
            my $instruction = $0.Str;
            my $movement = $1.Num;
            given $instruction {
                when "F" {
                    %acc = move(%acc, %acc{"direction"}, $movement);
                }
                when /L || R/ {
                    %acc{"direction"} = turn(%acc{"direction"}, $instruction, $movement);
                }
                default {
                    %acc = move(%acc, get-direction($instruction), $movement);
                }
            }
        }
        %acc;
    }, {"direction" => East, "X" => 0, "Y" => 0}, |@input;
    abs(%final<X>) + abs(%final<Y>);
}

multi sub MAIN("part1", "test"){
    ok solve("input-test".IO.lines()) == 25, " => 25";
}

multi sub MAIN("part1") {
    say solve("input".IO.lines());
}

# Problem 2

sub solve2(@input){
}
multi sub MAIN("part2", "test"){
    #ok solve2("input-test".IO.lines()) == 1, " => 1";
}

multi sub MAIN("part2") {
   # say solve2("input".IO.lines());
}
