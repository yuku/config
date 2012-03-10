r"""Command-line tool to convert CSV to JSON

  $ other cmd | python -m filter.csv2json [options]

Sample:
  $ cat sample.csv
  Year,Make,Model,Length
  1997,Ford,E350,2.34
  2000,Mercury,Cougar,2.38

  $ python -m filter.csv2json < sample.csv
  [
    {
      "Length": "2.34", 
      "Make": "Ford", 
      "Model": "E350", 
      "Year": "1997"
    },
    {
      "Length": "2.38", 
      "Make": "Mercury", 
      "Model": "Cougar", 
      "Year": "2000"
    }
  ]

  $ cat sample.csv | python -m filter.csv2json -t issf
  [
    {
      "Length": 2.34, 
      "Make": "Ford", 
      "Model": "E350", 
      "Year": 1997
    }, 
    {
      "Length": 2.38, 
      "Make": "Mercury", 
      "Model": "Cougar", 
      "Year": 2000
    }
  ]
"""

import sys
import csv
import json
import optparse


def main():
    parser = optparse.OptionParser(usage=__doc__)
    parser.add_option("-i", "--input", dest="input", metavar="INPUT",
                      default=sys.stdin,
                      help=("The path to the CSV file. It defaults to "
                            "standard input stream."))
    parser.add_option("-o", "--output", dest="output", metavar="OUTPUT",
                      default=sys.stdout,
                      help=("The path to the output JSON file. It defaults to "
                            "standard output stream."))
    parser.add_option("-d", "--delimiter", dest="delimiter",
                      metavar="DELIMITER", default=",",
                      help=("A one-character string used to separate fields. "
                            "It defaults to ','."))
    parser.add_option("-q", "--quotechar", dest="quotechar",
                      metavar="QUOTECHAR", default='"',
                      help=("A one-character string used to quote fields "
                            "containing special characters, such as the "
                            "delimiter or quotechar, or which contain "
                            "new-line characters. It defaults to '\"'."))
    parser.add_option("-l", "--lineterminator", dest="lineterminator",
                      metavar="LINETERMINATOR", default="\r\n",
                      help=("The string used to terminate lines. It defaults "
                            "to '\\r\\n'."))
    parser.add_option("-t", "--typedef", dest="typedef",
                      metavar="TYPE DEFINITIONS",
                      help=("A string used to declare type of each field. i, "
                            "f, s are available. It defaults to treat all "
                            "values as string."))

    opts, args = parser.parse_args()

    reader = csv.reader(opts.input,
                        delimiter=opts.delimiter,
                        quotechar=opts.quotechar,
                        lineterminator=opts.lineterminator)

    _iter = iter(reader)
    fields = next(_iter)
    
    if opts.typedef is None:
        typedef = 's' * len(fields)
    elif len(opts.typedef) < len(fields):
        typedef = opts.typedef + 's' * (len(fields) - len(opts.typedef))
    else:
        typedef = opts.typedef 

    cast = {
        's': lambda x: x,
        'i': lambda x: int(x),
        'f': lambda x: float(x),
    }

    obj = []
    for row in _iter:
        o = {}
        for i, [key, value] in enumerate(zip(fields, row)):
            o[key] = cast[typedef[i]](value)
        obj.append(o)

    json.dump(obj, opts.output, sort_keys=True, indent=2)
    opts.output.write('\n')


if __name__ == "__main__":
    main()
