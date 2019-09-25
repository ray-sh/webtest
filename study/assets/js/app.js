// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
import socket from "./socket"

function refresh(content) {
    //refresh side bar
    $("#cars").empty()

    $("#cars").append(refresh_cars(content.cars))
}

function refresh_cars(cars) {
    var i;
    var result = "";
    for( i = 0; i<cars.length; i++)
    {
        result = result + "<li><a>" + cars[i] + "</a></li>"
    }
    return result
}