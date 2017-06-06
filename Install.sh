#!/bin/sh
cd ~/
function confirm( )
{
#alert the user what they are about to do.
echo "About to $@....";
#confirm with the user
read -r -p "Are you sure? [Y/n]" response
case "$response" in
    [yY][eE][sS]|[yY]) 
              #if yes, then execute the passed parameters
               "$@"
               ;;
    *)
              #Otherwise exit...
              echo "Abort."
              exit
              ;;
esac
}
target=The-Powder-Toy
if find "$target" -mindepth 1 -print -quit | grep -q .; then
    echo "WARNING: YOUR INSTALL DIRECORY IS NOT EMPTY! BACKUP ANY IMPORTANT DATA INSIDE OF THE FOLDER ~/The-Powder-Toy!"
    confirm rm -R ~/The-Powder-Toy
else
    echo ''
fi
clear
echo "Cores to use:"
read CORES
echo "Using $CORES cores on the CPU"
sudo apt-get install build-essential libsdl1.2-dev libbz2-dev zlib1g-dev liblua5.1.0-dev git scons libfftw3-dev python
cd ~/
git clone git://github.com/ThePowderToy/The-Powder-Toy.git
cd ~/The-Powder-Toy
scons --no-sse "-j$CORES"
cd ~/The-Powder-Toy
ln -s ./build/powder ThePowderToy
echo "Finished."
