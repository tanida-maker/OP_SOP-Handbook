"use client";

import { useCallback, useRef, useState } from "react";
import { useEditor, EditorContent, type Editor as TiptapEditor } from "@tiptap/react";
import StarterKit from "@tiptap/starter-kit";
import Image from "@tiptap/extension-image";
import Link from "@tiptap/extension-link";
import Youtube from "@tiptap/extension-youtube";
import Placeholder from "@tiptap/extension-placeholder";
import Underline from "@tiptap/extension-underline";
import { TextStyle, FontSize } from "@tiptap/extension-text-style";
import {
  Bold,
  Film,
  Heading2,
  Heading3,
  ImagePlus,
  Italic,
  Link2,
  List,
  ListOrdered,
  Loader2,
  MonitorPlay,
  Quote,
  Redo2,
  Underline as UnderlineIcon,
  Undo2,
} from "lucide-react";
import { createClient } from "@/lib/supabase/client";
import { Video } from "./VideoNode";

function ToolbarButton({
  onClick,
  active,
  title,
  children,
}: {
  onClick: () => void;
  active?: boolean;
  title: string;
  children: React.ReactNode;
}) {
  return (
    <button
      type="button"
      title={title}
      onClick={onClick}
      className={`grid h-9 w-9 place-items-center rounded-lg border text-sm transition ${
        active
          ? "border-brand-400 bg-brand-50 text-brand-700"
          : "border-transparent text-muted hover:bg-surface-2 hover:text-text"
      }`}
    >
      {children}
    </button>
  );
}

export default function Editor({
  value,
  onChange,
}: {
  value: string;
  onChange: (html: string) => void;
}) {
  const [uploading, setUploading] = useState<null | "image" | "video">(null);
  const imageInput = useRef<HTMLInputElement>(null);
  const videoInput = useRef<HTMLInputElement>(null);

  const editor = useEditor({
    immediatelyRender: false, // required for Next.js SSR
    extensions: [
      StarterKit,
      Underline,
      TextStyle,
      FontSize,
      Image.configure({ inline: false }),
      Link.configure({ openOnClick: false, autolink: true }),
      Youtube.configure({ nocookie: true, controls: true, width: 640, height: 360 }),
      Video,
      Placeholder.configure({
        placeholder: "เริ่มพิมพ์เนื้อหาคู่มือที่นี่...",
      }),
    ],
    content: value || "",
    onUpdate: ({ editor }) => onChange(editor.getHTML()),
    editorProps: {
      attributes: {
        class: "prose max-w-none focus:outline-none",
      },
    },
  });

  const upload = useCallback(
    async (file: File, kind: "image" | "video") => {
      if (!editor) return;
      setUploading(kind);
      try {
        const supabase = createClient();
        const ext = file.name.split(".").pop() || "bin";
        const path = `${kind}s/${crypto.randomUUID()}.${ext}`;
        const { error } = await supabase.storage
          .from("sop-media")
          .upload(path, file, { cacheControl: "3600", upsert: false });
        if (error) throw error;
        const {
          data: { publicUrl },
        } = supabase.storage.from("sop-media").getPublicUrl(path);

        if (kind === "image") {
          editor.chain().focus().setImage({ src: publicUrl }).run();
        } else {
          editor
            .chain()
            .focus()
            .insertContent({ type: "video", attrs: { src: publicUrl } })
            .run();
        }
      } catch (e) {
        alert(
          "อัปโหลดไม่สำเร็จ: " +
            (e instanceof Error ? e.message : "unknown error") +
            "\n(ตรวจสอบว่าคุณเป็นแอดมินและตั้งค่า Storage แล้ว)"
        );
      } finally {
        setUploading(null);
      }
    },
    [editor]
  );

  if (!editor) {
    return (
      <div className="grid h-64 place-items-center rounded-xl border border-border bg-surface text-muted">
        <Loader2 className="animate-spin" />
      </div>
    );
  }

  return (
    <div className="overflow-hidden rounded-xl border border-border bg-surface">
      {/* Toolbar */}
      <div className="flex flex-wrap items-center gap-1 border-b border-border bg-surface-2/60 p-2">
        <ToolbarButton
          title="เลิกทำ"
          onClick={() => editor.chain().focus().undo().run()}
        >
          <Undo2 size={17} />
        </ToolbarButton>
        <ToolbarButton
          title="ทำซ้ำ"
          onClick={() => editor.chain().focus().redo().run()}
        >
          <Redo2 size={17} />
        </ToolbarButton>
        <span className="mx-1 h-6 w-px bg-border" />
        <ToolbarButton
          title="ตัวหนา"
          active={editor.isActive("bold")}
          onClick={() => editor.chain().focus().toggleBold().run()}
        >
          <Bold size={17} />
        </ToolbarButton>
        <ToolbarButton
          title="ตัวเอียง"
          active={editor.isActive("italic")}
          onClick={() => editor.chain().focus().toggleItalic().run()}
        >
          <Italic size={17} />
        </ToolbarButton>
        <ToolbarButton
          title="ขีดเส้นใต้"
          active={editor.isActive("underline")}
          onClick={() => editor.chain().focus().toggleUnderline().run()}
        >
          <UnderlineIcon size={17} />
        </ToolbarButton>
        <select
          title="ขนาดตัวอักษร"
          className="h-9 rounded-lg border border-border bg-surface px-2 text-sm text-text hover:bg-surface-2"
          value={(editor.getAttributes("textStyle").fontSize as string) || ""}
          onChange={(e) => {
            const v = e.target.value;
            if (!v) editor.chain().focus().unsetFontSize().run();
            else editor.chain().focus().setFontSize(v).run();
          }}
        >
          <option value="">ขนาดปกติ</option>
          <option value="13px">เล็ก</option>
          <option value="18px">ใหญ่</option>
          <option value="22px">ใหญ่มาก</option>
          <option value="28px">ใหญ่พิเศษ</option>
        </select>
        <span className="mx-1 h-6 w-px bg-border" />
        <ToolbarButton
          title="หัวข้อใหญ่"
          active={editor.isActive("heading", { level: 2 })}
          onClick={() =>
            editor.chain().focus().toggleHeading({ level: 2 }).run()
          }
        >
          <Heading2 size={17} />
        </ToolbarButton>
        <ToolbarButton
          title="หัวข้อย่อย"
          active={editor.isActive("heading", { level: 3 })}
          onClick={() =>
            editor.chain().focus().toggleHeading({ level: 3 }).run()
          }
        >
          <Heading3 size={17} />
        </ToolbarButton>
        <ToolbarButton
          title="รายการหัวข้อ"
          active={editor.isActive("bulletList")}
          onClick={() => editor.chain().focus().toggleBulletList().run()}
        >
          <List size={17} />
        </ToolbarButton>
        <ToolbarButton
          title="รายการลำดับเลข"
          active={editor.isActive("orderedList")}
          onClick={() => editor.chain().focus().toggleOrderedList().run()}
        >
          <ListOrdered size={17} />
        </ToolbarButton>
        <ToolbarButton
          title="คำพูด/ข้อควรระวัง"
          active={editor.isActive("blockquote")}
          onClick={() => editor.chain().focus().toggleBlockquote().run()}
        >
          <Quote size={17} />
        </ToolbarButton>
        <ToolbarButton
          title="ลิงก์"
          active={editor.isActive("link")}
          onClick={() => {
            const prev = editor.getAttributes("link").href as string | undefined;
            const url = window.prompt("ใส่ลิงก์ (URL):", prev || "https://");
            if (url === null) return;
            if (url === "") {
              editor.chain().focus().unsetLink().run();
              return;
            }
            editor
              .chain()
              .focus()
              .extendMarkRange("link")
              .setLink({ href: url })
              .run();
          }}
        >
          <Link2 size={17} />
        </ToolbarButton>
        <span className="mx-1 h-6 w-px bg-border" />
        <ToolbarButton
          title="แทรกรูปภาพ"
          onClick={() => imageInput.current?.click()}
        >
          {uploading === "image" ? (
            <Loader2 size={17} className="animate-spin" />
          ) : (
            <ImagePlus size={17} />
          )}
        </ToolbarButton>
        <ToolbarButton
          title="อัปโหลดวิดีโอ"
          onClick={() => videoInput.current?.click()}
        >
          {uploading === "video" ? (
            <Loader2 size={17} className="animate-spin" />
          ) : (
            <Film size={17} />
          )}
        </ToolbarButton>
        <ToolbarButton
          title="ฝังวิดีโอ YouTube"
          onClick={() => {
            const url = window.prompt("วางลิงก์ YouTube:");
            if (url) editor.commands.setYoutubeVideo({ src: url });
          }}
        >
          <MonitorPlay size={17} />
        </ToolbarButton>
      </div>

      {/* Editable area */}
      <div className="max-h-[60vh] overflow-y-auto px-4 py-3">
        <EditorContent editor={editor} />
      </div>

      <input
        ref={imageInput}
        type="file"
        accept="image/*"
        hidden
        onChange={(e) => {
          const f = e.target.files?.[0];
          if (f) upload(f, "image");
          e.target.value = "";
        }}
      />
      <input
        ref={videoInput}
        type="file"
        accept="video/*"
        hidden
        onChange={(e) => {
          const f = e.target.files?.[0];
          if (f) upload(f, "video");
          e.target.value = "";
        }}
      />
    </div>
  );
}
