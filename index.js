import {NativeModules} from "react-native";
const {RNBugsnag} = NativeModules;

export function notify(errorMessage, errorReason) {
  return RNBugsnag.notify(errorMessage, errorReason);
}

export function setUser(userID, userName, userEmail="") {
  return RNBugsnag.setUser(userID, userName, userEmail);
}

export function removeUser() {
  return RNBugsnag.setUser(null, null, null);
}

export function leaveBreadcrumb(name, metadata={}) {
  return RNBugsnag.setUser(name, metadata);
}

export default {
  notify,
  setUser,
  removeUser,
  leaveBreadcrumb,
};
