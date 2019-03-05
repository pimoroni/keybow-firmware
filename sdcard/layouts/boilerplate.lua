require "keybow"

-- Handy bits of boilerplate text like Lorem Ipsum --

-- Key mappings --

function handle_key_00(pressed) -- Lorem Ipsum
    if pressed then
        keybow.text([[
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam fermentum ante ac 
tellus maximus, a tristique ligula sollicitudin. Mauris in molestie purus, a 
dapibus libero. Duis at dolor nulla. Aliquam neque tortor, molestie ut lacus 
sed, cursus gravida enim. Nunc venenatis, metus nec aliquam congue, odio felis 
lobortis lectus, et ullamcorper dolor odio quis sapien. Ut sed pellentesque 
nibh, ac cursus dui. Quisque a porta dui. Nullam eu dui ut lacus convallis 
sagittis. Aenean commodo mauris in nulla placerat semper. Quisque nulla 
sapien, dignissim at semper sit amet, volutpat sit amet dolor. Cras et purus 
pretium nisl laoreet venenatis quis nec nisl. Cras aliquet id nisi vitae porta.
]])
    end
end

function handle_key_01(pressed) -- Bacon Ipsum
    if pressed then
        keybow.text([[
Bacon ipsum dolor amet capicola spare ribs landjaeger bresaola biltong salami 
flank meatball chuck fatback picanha. Pancetta pork loin ball tip shoulder 
bresaola meatloaf pastrami sirloin porchetta leberkas. Drumstick brisket 
ground round, andouille corned beef shankle chicken meatloaf tenderloin jerky 
bresaola jowl frankfurter pancetta shoulder. Shoulder ribeye corned beef 
sirloin prosciutto meatloaf cow brisket beef pastrami.
]])
    end
end

function handle_key_02(pressed) -- Zombie Ipsum
    if pressed then
        keybow.text([[
Zombie ipsum reversus ab viral inferno, nam rick grimes malum cerebro. De 
carne lumbering animata corpora quaeritis. Summus brains sit​​, morbo vel 
maleficia? De apocalypsi gorger omero undead survivor dictum mauris. Hi 
mindless mortuis soulless creaturas, imo evil stalking monstra adventus resi 
dentevil vultus comedat cerebella viventium. Qui animated corpse, cricket bat 
max brucks terribilem incessu zomby. The voodoo sacerdos flesh eater, suscitat 
mortuos comedere carnem virus. Zonbi tattered for solum oculi eorum defunctis 
go lum cerebro. Nescio brains an Undead zombies. Sicut malus putrid voodoo 
horror. Nigh tofth eliv ingdead.
]])
    end
end

function handle_key_03(pressed) -- Pangrams
    if pressed then
        keybow.text("The quick brown fox jumps over the lazy dog.")
    end
end

function handle_key_04(pressed)
    if pressed then
        keybow.text("Pack my box with five dozen liquor jugs.")
    end
end

function handle_key_05(pressed)
    if pressed then
        keybow.text("How quickly daft jumping zebras vex.")
    end
end

function handle_key_06(pressed) -- Python shebang
    if pressed then
        keybow.text("£!/usr/bin/env python\n\n")
    end
end

function handle_key_07(pressed) -- Python while loop
    if pressed then
        keybow.text("while True:")
    end
end

function handle_key_08(pressed) -- Python for loop
    if pressed then
        keybow.text("for i in range(len()):")
    end
end

function handle_key_09(pressed) -- Bash shebang
    if pressed then
        keybow.text("£!/usr/bin/env bash\n\n")
    end
end

function handle_key_10(pressed) -- HTML boilerplate (from https://gist.github.com/soniacs/4381504)
    if pressed then
        keybow.text([[
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>HTML 5 complete</title>
<!-- styles -->
<link rel="stylesheet" type="text/css" href="css/normalize.css">
<link rel="stylesheet" type="text/css" href="css/default.css">
<!-- scripts -->
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.9.2/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/default.js"></script>
</head>

<body>
<header class="site-header">
<div class="wrapper">
</div>
</header>

<div class="site-content">
<div class="wrapper">
</div>
</div>

<footer class="site-footer">
<div class="wrapper">
</div>
</footer>
</body>
</html>
]])
    end

end

function handle_key_11(pressed) -- CSS boilerplate (from https://gist.github.com/soniacs/4381504)
    if pressed then
        keybow.text([[
@font-face {}

/* COMMON STYLES */

/* LAYOUT */
/* {position:absolute;} */
/* {position:relative;} */
/* {float:left;} */
/* {float:right;} */
/* {overflow:hidden;} */
/* {display:block;} */
/* {display:inline;} */
/* {display:none;} */
/* {margin:0} */
/* {padding:0;} */
/* {width:100%;} */

/* TYPOGRAPHY */
/* {line-height:1;} */
/* {list-style-type:none;} */
/* {font-size:1em;} */
/* {font-style:italic;} */
/* {font-style:normal;} */
/* {font-weight:bold;} */
/* {font-weight:normal;} */
/* {text-align:center;} */
/* {text-align:right;} */
/* {text-align:left;} */
/* {text-decoration:underline;} */
/* {text-decoration:none;} */
/* {text-transform:uppercase;} */
/* {text-transform:none;} */

/* COLOR */
/* {background-color: #fff;} */
/* {background-color: transparent;} */
/* {border: 1px solid #000;} */
/* {border: none;} */
/* {color: #000;} */
/* {border-radius: 0px;} */
/* {transition: all 0.3s ease-in-out;} */

/* BASE */
body{}
::selection, ::moz-selection{}
.wrapper{}

/* HEADER */
.site-header{}

/* FOOTER */
.site-footer{}


/* CONTENT */
.site-content{}

/* LAYOUT */

/* BASIC ELEMENTS */
div{}
p{}
blockquote{}
code{}
img{}
a{}
em{}
strong{}
pre{}

/* HEADINGS */
h1{}
h2{}
h3{}
h4{}
h5{}
h6{}

/* FORMS & BUTTONS */
form{}
fieldset{}
legend{}
label{}
input{}
textarea{}
select{}

/* TABLES */
table{}
caption{}
tr{}
thead{}
th{}
tbody{}
td{}
tfoot{}

/* LISTS */
dl{}
dt{}
dd{}
ol{}
ol li{}
ul{}
ul li{}
]])
    end
end
