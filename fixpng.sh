# Fix an iOS-converted PNG
# By Tom Harrington, June 1 2012.

fixpng () {
	if [ -z "$1" ]; then
		echo "Usage: fixpng <inputFile> [outputFile]"
		return -1
	else
		inputFile=$1
		
		# Only "png" and "PNG" are allowed
		pngRegex='.*.(png|PNG)$'
		if [[ $inputFile =~ $pngRegex ]]; then
			if [ -n "$2" ]; then
				# Use whatever name was provided
				outputFile=$2
			else
				# Generate a filename, preserve file extension case.
				extension=${BASH_REMATCH[1]}
				outputFile=${inputFile%.$extension}-fixed.$extension
			fi
			echo "Converting $inputFile to $outputFile"
			
			xcrun -sdk iphoneos pngcrush -q -revert-iphone-optimizations $inputFile $outputFile
		else
			echo "Skipping $inputFile since it's not a png"
		fi
	fi
}

# Fix a whole mess of pngs at once
fixpngs () {
	if [ -z "$1" ]; then
		echo "Usage: fixpng <inputFiles> [outputFile]"
		return -1
	else
		for file in "$@"; do fixpng $file; done
	fi

}
