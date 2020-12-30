use Test;

# Day 3, Problem 1

sub load-input(@input){
    reduce sub (%acc, $str){
        if $str ~~ /(\w+ \s+  \w+)\s+ "bags contain no other bags."/ {
            %acc{$0.Str} = {};
        } elsif $str ~~ /(\w+ \s+ \w+) \s+ bags \s+ contain \s+ ((\d+) \s+ ((\w+ \s+ \w+)\s+ bag s*\S\s*))+ / {
            %acc{$0.Str} = reduce sub (%bags, $match) {
                %bags{$match[1][0].Str} = $match[0].Int;
                %bags;
            }, {}, |$1;
        }
        %acc;
    }, {}, |@input;
}
sub solve(@input) {
    say load-input(@input);
}

multi sub MAIN("part1", "test"){
    ok solve("input-test".IO.lines()) == 4, " => 4";
}

multi sub MAIN("part1") {
    #say solve("input".IO.lines());
}

# Day 3, Problem 2

sub solve2(@input){
}
multi sub MAIN("part2", "test"){
    #ok solve2("input-test".IO.lines()) == 1, " => 1";
}

multi sub MAIN("part2") {
   # say solve2("input".IO.lines());
}

