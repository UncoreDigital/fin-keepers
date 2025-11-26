export function GET() {
  const body = [
    "User-agent: *",
    "Disallow:",
    "Disallow: /cgi-bin/",
    "Sitemap: https://www.finkeepers.us/sitemap.xml",
    "",
  ].join("\n");

  return new Response(body, {
    headers: {
      "Content-Type": "text/plain; charset=utf-8",
    },
  });
}


