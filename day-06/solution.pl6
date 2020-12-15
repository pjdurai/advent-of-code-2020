use Test;

# Problem 1

sub load-input($input-file){
    ($input-file.IO.slurp
     ==> split(/\n\n/)
     ==> map({.split(/\n/)})
    );
}

sub solve($input-file) {
    my @input = load-input($input-file);
    [+] @input.map({.join("").comb.unique.elems});
}

multi sub MAIN("part1", "test"){
    ok solve("input-test") == 11, " => 11";
}

multi sub MAIN("part1") {
    say solve("input");
}

# Problem 2

sub solve2($input-file){
    my @input = load-input($input-file);
    say @input.perl;
    @input.map(-> @group {
                      say @group.perl;
                  });
}
multi sub MAIN("part2", "test"){
    ok solve2("input-test") == 6, " => 6";
}

multi sub MAIN("part2") {
   # say solve2("input".IO.lines());

}
