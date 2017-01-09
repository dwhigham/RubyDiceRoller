require 'tk'
require 'tkextlib/tile'
# Set name of GUI  and size of window
root = TkRoot.new {title "Dice Roller"}
content = Tk::Tile::Frame.new(root) {padding "3 3 12 12"}.grid( :sticky => 'nsew')
TkGrid.columnconfigure root, 0, :weight => 1; TkGrid.rowconfigure root, 0, :weight => 1

# Set Labels used and textbox
$typeofdice = TkVariable.new; $dicerolled = TkVariable.new
f = Tk::Tile::Entry.new(content) {width 7; textvariable $typeofdice}.grid( :column => 2, :row => 1, :sticky => 'we' )
Tk::Tile::Label.new(content) {textvariable $dicerolled}.grid( :column => 2, :row => 2, :sticky => 'we');
Tk::Tile::Button.new(content) {text 'Calculate'; command {roll}}.grid( :column => 3, :row => 3, :sticky => 'w')

Tk::Tile::Label.new(content) {text 'Enter type of Dice: '}.grid( :column => 3, :row => 1, :sticky => 'w')
Tk::Tile::Label.new(content) {text 'Number rolled'}.grid( :column => 3, :row => 2, :sticky => 'w')

TkWinfo.children(content).each {|w| TkGrid.configure w, :padx => 5, :pady => 5}
f.focus
root.bind("Return") {roll}

# Takes input from text box and generates a random number between 1 and that value.
# This value is then passed back on screen

def roll(number=1)
  roll_array = []
  number.times do
    roll_value = rand($typeofdice) + 1
    roll_array << roll_value
  end
  total = 0
  roll_array.each do |roll|
    new_total = total + roll
    total = new_total
  end
  total
  $dicerolled.value = total
end
Tk.mainloop
