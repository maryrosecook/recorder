require 'data'

describe Data, "#write_datum" do
  it "writes two data to a new bucket and read them back" do
    bucket = "10.1.1.1"
    identifier_1 = "killenemy"
    identifier_2 = "duck"
    datum_1 = "1"
    datum_2 = "0"

    Data.write_datum bucket, identifier_1, datum_1
    Data.write_datum bucket, identifier_2, datum_2
    Data.read_datum(bucket, identifier_1).should match(datum_1)
    Data.read_datum(bucket, identifier_2).should match(datum_2)
  end

  it "overwrites an existing datum" do
    bucket = "10.1.1.1"
    identifier = "killenemy"
    datum_1 = "1"
    datum_2 = "0"

    Data.write_datum bucket, identifier, datum_1
    Data.write_datum bucket, identifier, datum_2
    Data.read_datum(bucket, identifier).should match(datum_2)
  end

  it "writes identical backup data" do
    bucket = "10.1.1.1"
    identifier_1 = "killenemy"
    identifier_2 = "duck"
    datum = "1"

    Data.write_datum bucket, identifier_1, datum
    Data.write_datum bucket, identifier_2, datum
    data = Data.read_data_from_file(Data.get_filename(bucket))
    data[identifier_1].should match(datum)
    data[identifier_2].should match(datum)
  end
end
