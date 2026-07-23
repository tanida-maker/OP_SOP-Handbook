// Renders SOP body HTML produced by the Tiptap editor.
// Content is authored only by trusted admins (RLS-guarded), so we render
// the stored HTML directly inside the themed ".prose" wrapper.
export default function ContentRenderer({ html }: { html: string }) {
  if (!html || html.trim() === "" || html === "<p></p>") {
    return (
      <p className="text-muted italic">ยังไม่มีเนื้อหาในคู่มือนี้</p>
    );
  }
  return (
    <div className="prose" dangerouslySetInnerHTML={{ __html: html }} />
  );
}
