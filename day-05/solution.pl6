use Test;

# Day 5, Problem 1

my $ROWS = 128;
my $COLS = 8;

sub find-row($spec-str){
    my @rows = [0..^$ROWS];
    (reduce sub (@acc, $spec){
        given $spec {
            when "F" {@acc[0..(@acc.elems/2)-1]}
            when "B" {@acc[(@acc.elems/2) .. *-1]}
        }
    }, @rows, |$spec-str.comb).head;
}

sub find-column($spec-str){
    my @cols = [0..^$COLS];
    (reduce sub (@acc, $spec){
        given $spec {
            when "L" {@acc[0..(@acc.elems/2)-1]}
            when "R" {@acc[(@acc.elems/2) .. *-1]}
        }
    }, @cols, |$spec-str.comb).head;
}

sub find-seat-ids(@input){
    @input.map(-> $spec {
                      my $row = find-row($spec.substr(0..6));
                      my $col = find-column($spec.substr(7..9));
                      $row * 8 + $col;
                  });
}

sub solve(@input) {
    my @seat-ids = find-seat-ids(@input);
    @seat-ids.sort[*-1];
}

multi sub MAIN("part1", "test"){
    my @test-input = <BFFFBBFRRR FFFBBBFRRR BBFFBBFRLL>;
    ok solve(@test-input) == 820, " => 820";
}

multi sub MAIN("part1") {
    say solve("input".IO.lines());
}

# Day 5, Problem 2

sub solve2(@input){

    my @seat-ids = find-seat-ids("input".IO.lines()).sort;
    my @all-ids = [@seat-ids[0]..@seat-ids[*-1]];
    say (@all-ids (-) @seat-ids).keys[0];
}

multi sub MAIN("part2") {
    solve2("input".IO.lines());
}
