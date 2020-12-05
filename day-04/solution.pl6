use Test;

# Day 4, Problem 1

my @all-fields = ("hgt", "eyr", "ecl", "byr", "iyr", "hcl", "cid", "pid");

sub load-input($input-file){
    # cleanup the input and parse it into an array of hashes representing passport data
    ($input-file.IO.slurp
     ==> split(/\n\n/)
     ==> map({.split(/\n/).join(" ")})
     ==> map({.words})
     ==> map(-> @record {
                    reduce sub (%acc, $name-value){
                        my @kv = $name-value.split(/\:/);
                        %acc{@kv[0]} = @kv[1];
                        %acc;
                    }, {}, |@record;
                });
    );
}

# Check if the passport hash has all the fields. (cid optional)
sub check-for-fields(%passport){
    my @keys = %passport.keys;
    my @diff = @(@all-fields (-) @keys);
    @diff.elems == 0 || (@diff.elems == 1 && @diff[0].key.Str eq "cid")
}

sub solve($input-file) {
    my @passports = load-input($input-file);
    # Count vlid passports
    reduce sub ($count, %pp){
        check-for-fields(%pp) ?? $count+1 !! $count;
    }, 0, |@passports;
}

multi sub MAIN("part1", "test"){
    ok solve("input-test") == 2, " => 2";
}

multi sub MAIN("part1") {
    say solve("input");
}

# Day 4, Problem 2

sub solve2(@input){
}
multi sub MAIN("part2", "test"){
    #ok solve2("input-test".IO.lines()) == 1, " => 1";
}

multi sub MAIN("part2") {
   # say solve2("input".IO.lines());
}
