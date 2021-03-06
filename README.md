## Purpose
* This is a very simple CLI written as a ruby gem.
* This gem's current function is to display winds and temps aloft.
* This gem was made with the help of Janice Smith's write-up [Creating a CLI ruby gem!](https://medium.com/@theorynest/creating-a-cli-ruby-gem-1dbf0990652b#.bx85273tb).
* Currently this gem is using a sample file to display data. Later version will include making a request to https://aviationweather.gov/windtemp/ for all regions

## Dependencies

Ruby, Bundler

## Running
### Get the code
`git clone https://github.com/pocketIlmatto/wind_temp_aloft.git`

### Use the correct ruby version
`rvm use 2.5.1`

### Install It locally
`rake install`

### To Run Tests
`rake spec`

### Check it out
`wind_temp_aloft help`

## Usage
### To display all altitudes for an airport code

- `wind_temp_aloft show IMB all`
```sh
Altitude: 3000' Direction: na, Speed: na kts, Temperature: na C
Altitude: 6000' Direction: na, Speed: na kts, Temperature: na C
Altitude: 9000' Direction: 230, Speed: 15 kts, Temperature: -09 C
Altitude: 12000' Direction: 210, Speed: 29 kts, Temperature: -13 C
Altitude: 18000' Direction: 230, Speed: 69 kts, Temperature: -23 C
Altitude: 24000' Direction: 240, Speed: 87 kts, Temperature: -35 C
Altitude: 30000' Direction: 240, Speed: 112 kts, Temperature: -49 C
Altitude: 34000' Direction: 250, Speed: 119 kts, Temperature: -58 C
Altitude: 39000' Direction: 260, Speed: 68 kts, Temperature: -55 C
```

### To display specific altitude for airport code

- `wind_temp_aloft show SFO 3000`

### To display available airport codes

- `wind_temp_aloft codes`
```sh
BIH, BLH, FAT, FOT, ONT, RBL, SAC, SAN, SBA, SFO, SIY, WJF, AST, IMB, LKV, OTH, PDX, RDM, GEG, SEA, YKM
```

## Resources
* [Bundler Gem](https://github.com/bundler/bundler)
* [Bundler Docs](http://bundler.io/v1.14/man/bundle-gem.1.html)

MIT License

Copyright (c) 2017 Janice K.N. Smith

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.