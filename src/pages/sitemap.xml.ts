export function GET() {
  const currentDate = new Date().toISOString();
  
  const body = `<?xml version="1.0" encoding="UTF-8"?>
<urlset
      xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9
            http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">

<!-- Homepage -->
<url>
  <loc>https://finkeepers.us/</loc>
  <lastmod>${currentDate}</lastmod>
  <changefreq>weekly</changefreq>
  <priority>1.00</priority>
</url>

<!-- Main Service Pages -->
<url>
  <loc>https://finkeepers.us/book-keeping</loc>
  <lastmod>${currentDate}</lastmod>
  <changefreq>monthly</changefreq>
  <priority>0.90</priority>
</url>
<url>
  <loc>https://finkeepers.us/financial-reporting</loc>
  <lastmod>${currentDate}</lastmod>
  <changefreq>monthly</changefreq>
  <priority>0.90</priority>
</url>
<url>
  <loc>https://finkeepers.us/payroll-assistance</loc>
  <lastmod>${currentDate}</lastmod>
  <changefreq>monthly</changefreq>
  <priority>0.90</priority>
</url>
<url>
  <loc>https://finkeepers.us/cashflow-management</loc>
  <lastmod>${currentDate}</lastmod>
  <changefreq>monthly</changefreq>
  <priority>0.90</priority>
</url>
<url>
  <loc>https://finkeepers.us/temporary-cfo</loc>
  <lastmod>${currentDate}</lastmod>
  <changefreq>monthly</changefreq>
  <priority>0.90</priority>
</url>

<!-- Important Pages -->
<url>
  <loc>https://finkeepers.us/pricing</loc>
  <lastmod>${currentDate}</lastmod>
  <changefreq>monthly</changefreq>
  <priority>0.85</priority>
</url>
<url>
  <loc>https://finkeepers.us/about</loc>
  <lastmod>${currentDate}</lastmod>
  <changefreq>monthly</changefreq>
  <priority>0.80</priority>
</url>
<url>
  <loc>https://finkeepers.us/contact</loc>
  <lastmod>${currentDate}</lastmod>
  <changefreq>monthly</changefreq>
  <priority>0.80</priority>
</url>

<!-- Content Pages -->
<url>
  <loc>https://finkeepers.us/blogs</loc>
  <lastmod>${currentDate}</lastmod>
  <changefreq>weekly</changefreq>
  <priority>0.75</priority>
</url>
<url>
  <loc>https://finkeepers.us/casestudy</loc>
  <lastmod>${currentDate}</lastmod>
  <changefreq>monthly</changefreq>
  <priority>0.75</priority>
</url>

<!-- Blog Posts -->
<url>
  <loc>https://finkeepers.us/blog/post-1</loc>
  <lastmod>${currentDate}</lastmod>
  <changefreq>yearly</changefreq>
  <priority>0.60</priority>
</url>
<url>
  <loc>https://finkeepers.us/blog/post-2</loc>
  <lastmod>${currentDate}</lastmod>
  <changefreq>yearly</changefreq>
  <priority>0.60</priority>
</url>

<!-- Case Studies -->
<url>
  <loc>https://finkeepers.us/casestudy/erp-transition</loc>
  <lastmod>${currentDate}</lastmod>
  <changefreq>yearly</changefreq>
  <priority>0.65</priority>
</url>
<url>
  <loc>https://finkeepers.us/casestudy/1</loc>
  <lastmod>${currentDate}</lastmod>
  <changefreq>yearly</changefreq>
  <priority>0.65</priority>
</url>
<url>
  <loc>https://finkeepers.us/casestudy/2</loc>
  <lastmod>${currentDate}</lastmod>
  <changefreq>yearly</changefreq>
  <priority>0.65</priority>
</url>

<!-- Additional Service Pages -->
<url>
  <loc>https://finkeepers.us/account-reconciliation</loc>
  <lastmod>${currentDate}</lastmod>
  <changefreq>monthly</changefreq>
  <priority>0.70</priority>
</url>
<url>
  <loc>https://finkeepers.us/audit-support</loc>
  <lastmod>${currentDate}</lastmod>
  <changefreq>monthly</changefreq>
  <priority>0.70</priority>
</url>
<url>
  <loc>https://finkeepers.us/financial-modeling</loc>
  <lastmod>${currentDate}</lastmod>
  <changefreq>monthly</changefreq>
  <priority>0.70</priority>
</url>
<url>
  <loc>https://finkeepers.us/fp-a</loc>
  <lastmod>${currentDate}</lastmod>
  <changefreq>monthly</changefreq>
  <priority>0.70</priority>
</url>
<url>
  <loc>https://finkeepers.us/historical-cleanup</loc>
  <lastmod>${currentDate}</lastmod>
  <changefreq>monthly</changefreq>
  <priority>0.70</priority>
</url>

<!-- Legal Pages -->
<url>
  <loc>https://finkeepers.us/privacy-policy</loc>
  <lastmod>${currentDate}</lastmod>
  <changefreq>yearly</changefreq>
  <priority>0.30</priority>
</url>

</urlset>`;

  return new Response(body, {
    headers: {
      "Content-Type": "application/xml; charset=utf-8",
    },
  });
}


