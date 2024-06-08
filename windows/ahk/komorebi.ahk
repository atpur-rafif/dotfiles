#SingleInstance Force

~LWin::Send "{Blind}{vkE8}"
#f::Return
#d::Return
#t::Send "{Alt down}t{Alt up}"

#i::{
  Run "komorebic cycle-workspace next", , "Hide" 
}

#u::{
  Run "komorebic cycle-workspace previous", , "Hide" 
}

#h::Run "komorebic focus left", , "Hide"
#j::Run "komorebic focus down", , "Hide"
#k::Run "komorebic focus up", , "Hide"
#l::Run "komorebic focus right", , "Hide"

#+h::Run "komorebic move left", , "Hide"
#+j::Run "komorebic move down", , "Hide"
#+k::Run "komorebic move up", , "Hide"
#+l::Run "komorebic move right", , "Hide"

#1::Run "komorebic focus-workspace 0", , "Hide"
#2::Run "komorebic focus-workspace 1", , "Hide"
#3::Run "komorebic focus-workspace 2", , "Hide"

#+1::Run "komorebic move-to-workspace 0", , "Hide"
#+2::Run "komorebic move-to-workspace 1", , "Hide"
#+3::Run "komorebic move-to-workspace 3", , "Hide"

#w::WinClose("A")
