import {NativeModules} from "react-native";
const {RNBugsnag} = NativeModules;

export function notify(errorMessage, errorReason) {
  return RNBugsnag.notifyWithMessage(errorMessage, errorReason);
}

export function setUser(userID, userName, userEmail="") {
  return RNBugsnag.setUser(userID, userName, userEmail);
}

export function clearUser() {
  return RNBugsnag.clearUser();
}

export function leaveBreadcrumb(name, metadata={}) {
  return RNBugsnag.leaveBreadcrumb(name, metadata);
}

export default {
  notify,
  setUser,
  removeUser,
  leaveBreadcrumb,
};
