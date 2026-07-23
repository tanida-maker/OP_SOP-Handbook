import { Node } from "@tiptap/core";

// Minimal block node so uploaded video files render as an inline <video> player.
export const Video = Node.create({
  name: "video",
  group: "block",
  atom: true,
  draggable: true,

  addAttributes() {
    return {
      src: { default: null },
    };
  },

  parseHTML() {
    return [{ tag: "video" }];
  },

  renderHTML({ HTMLAttributes }) {
    return [
      "video",
      { ...HTMLAttributes, controls: "true", preload: "metadata" },
    ];
  },
});
