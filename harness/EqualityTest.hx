// -*- mode:java; tab-width:4; c-basic-offset:4; indent-tabs-mode:nil -*-

package harness;

class EqualityTest extends haxe.unit.TestCase {
    var data1 : Array<Array<Dynamic>>;
    var data2 : Array<Array<Dynamic>>;
    var data3 : Array<Array<Dynamic>>;
    var data4 : Array<Array<Dynamic>>;

    override public function setup() {
        data1 = [['Country','Capital'],
                 ['  Ireland','Dublin'],
                 ['France',15],
                 ['Spain','     Barcelona']];
        data2 = [['Country','Capital'],
                 ['Ireland','  Dublin'],
                 ['France',15],
                 ['Spain','  Barcelona  ']];
        data3 = [['Country','Capital'],
                 ['Ireland','  Dublin'],
                 ['France',15],
                 ['Spain','  Madrid  ']];
        data4 = [['COUNTRY','Capital'],
                 ['IRELAND','DUBlin'],
                 ['France',15],
                 ['SPAIN','BARCELONA']];
    }

    public function testWhiteSpace(){
        var table1 = Native.table(data1);
        var table2 = Native.table(data2);
        var flags = new coopy.CompareFlags();
        flags.unchanged_context = 0;
        var o = coopy.Coopy.diff(table1,table2,flags);
        assertEquals(4,o.height);
        flags.ignore_whitespace = true;
        o = coopy.Coopy.diff(table1,table2,flags);
        assertEquals(1,o.height);
        var table3 = Native.table(data3);
        o = coopy.Coopy.diff(table1,table3,flags);
        assertEquals(2,o.height);
    }

    public function testCase(){
        var table1 = Native.table(data1);
        var table4 = Native.table(data4);
        var flags = new coopy.CompareFlags();
        flags.unchanged_context = 0;
        var o = coopy.Coopy.diff(table1,table4,flags);
        assertEquals(6,o.height);
        flags.ignore_case = true;
        flags.ignore_whitespace = true;
        o = coopy.Coopy.diff(table1,table4,flags);
        assertEquals(1,o.height);
    }
}
