import {NativeModules} from "react-native";
const {RNBugsnag} = NativeModules;

export function configure() {
}

export function notify() {
}

export function setUser(userID, userName, userEmail="") {
}

export function removeUser() {
}

export default {
  configure,
  notify,
  setUser,
  removeUser,
};
