
const dom = (object) => {
  let query;
  let response;
  if (object[0] === "." ) {
    response = document.querySelectorAll(`${object}`);
    if (response.length === 0) {
      query = "No DOM elements matching this class" + "( " + object + " )" + "!!!";
    } else {
      query = response;
    }
  } else if (object[0] === "#") {
    response = document.getElementById(`${object.substr(1)}`);
    if (response === null) {
      query = "DOM element not found!" + "( " + object + " )" + "!!!";
    } else {
      query = response;
    }
  } else {
    response = document.querySelectorAll(`${object}`);
    if (response.length === 0) {
      query = "No DOM elements matching this tag" + "( " + object + " )" + "!!!";
    } else {
      query = response;
    }
  }
  return query;
}

dom(".flexrow").forEach((flexrow) => {
  let currentRowOptions = flexrow.dataset.wrap;
  if (currentRowOptions) {
    if (currentRowOptions === "center") {
      flexrow.style.justifyContent = "center";
    } else if (currentRowOptions === "left") {
      flexrow.style.justifyContent = "flex-start";
    } else if (currentRowOptions === "right") {
      flexrow.style.justifyContent = "flex-end";
    }
  }
});

dom(".container-flexrow").forEach((containerGap) => {
  let currentContainerGap = containerGap.dataset.gap;
  if (currentContainerGap) {
    containerGap.style.padding = currentContainerGap;
    dom(".flexcol-gap").forEach((colGap) => {
      colGap.style.padding = currentContainerGap;
    });
  }
});



dom(".droplist-trigger").forEach((trigger) => {
  let currentId = trigger.dataset.droplist;
  if (currentId) {
    let currentObject = dom(currentId);
    trigger.addEventListener("click", (event) => {
      currentObject.classList.toggle("hidden");
    });
  }
});




