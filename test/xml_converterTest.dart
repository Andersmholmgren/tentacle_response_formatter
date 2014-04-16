library tentacle_response_formatter.test.XmlConverter;
import 'package:unittest/unittest.dart';
import 'package:tentacle_response_formatter/xml_converter.dart';

void main() {
  XmlConverter c = new XmlConverter();

  test("is singleton", () {
    expect(new XmlConverter(), equals(c));
  });

  test("convert without data returns empty response string", () {
    expect(c.convert().replaceAll('\r', ''), equals('<response></response>'));
  });

  test("convert with string data returns response string", () {
    expect(c.convert("asdf").replaceAll('\r', ''), equals('<response>asdf</response>'));
  });

  test("convert with int data returns response string", () {
    expect(c.convert(1).replaceAll('\r', ''), equals('<response>1</response>'));
  });

  test("convert with bool data returns response string", () {
    expect(c.convert(true).replaceAll('\r', ''), equals('<response>true</response>'));
  });

  test("convert with double data returns response string", () {
    expect(c.convert(1.55).replaceAll('\r', ''), equals('<response>1.55</response>'));
  });

  test("convert with array int data returns response string", () {
    var expected =
'''
<response>
   <item>0</item>
   <item>1</item>
   <item>2</item>
</response>
'''.replaceAll('\n', '');
    expect(c.convert([0, 1, 2]).replaceAll('\r', ''), equals(expected));
  });

  test("convert with array mixed data returns response string", () {
    var expected =
'''
<response>
   <item>0</item>
   <item>asdf</item>
   <item>true</item>
</response>
'''.replaceAll('\n', '');
    expect(c.convert([0, "asdf", true]).replaceAll('\r', ''), equals(expected));
  });

  test("convert with map mixed data returns response string", () {
    var expected =
'''
<response>
   <a>1</a>
   <b>asdf</b>
   <c>true</c>
</response>
'''.replaceAll('\n', '');

    expect(c.convert({"a":1, "b":"asdf", "c":true}).replaceAll('\r', ''), equals(expected));
  });

  test("convert with array of map mixed data returns response string", () {

    expect(c.convert([{"a":1, "b":"asdf", "c":false}, {"a":2, "b":"qwer", "c":true}]).replaceAll('\r', ''), equals(
'''
<response>
   <item>
      <a>1</a>
      <b>asdf</b>
      <c>false</c>
   </item>
   <item>
      <a>2</a>
      <b>qwer</b>
      <c>true</c>
   </item>
</response>'''.replaceAll('\n', '')
    ));
  });

  test("convert with map of array data returns response string", () {
    var expected =
'''
<response>
   <a>
      <item>0</item>
      <item>1</item>
      <item>2</item>
   </a>
   <b>
      <item>true</item>
      <item>asdf</item>
      <item>22.55566</item>
   </b>
</response>
'''.replaceAll('\n', '');
    expect(c.convert({"a":[0, 1, 2], "b":[true, "asdf", 22.55566]}).replaceAll('\r', ''), equals(expected));
  });

}