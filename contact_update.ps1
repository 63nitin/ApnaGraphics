$content = Get-Content "contact.html" -Raw

# 1. Inject CSS
$styleEnd = $content.IndexOf("</style>")
$css = @"
    /* ─── CONTACT PAGE STYLES ─────────────────────────── */
    .contact-hero {
      padding: 120px 0 80px;
      background: var(--white);
      border-bottom: var(--border);
    }
    .contact-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 0;
      border: var(--border);
      box-shadow: 16px 16px 0 var(--black);
      margin-top: 40px;
      background: var(--white);
    }
    @media (max-width: 1024px) {
      .contact-grid {
        grid-template-columns: 1fr;
      }
      .contact-left { border-right: none; border-bottom: var(--border); padding: 40px 24px; }
      .contact-right { padding: 40px 24px; }
    }
    .contact-left {
      padding: 60px;
      border-right: var(--border);
      background: var(--yellow);
      display: flex;
      flex-direction: column;
      justify-content: center;
    }
    .contact-right {
      padding: 60px;
      display: flex;
      flex-direction: column;
      justify-content: center;
      gap: 40px;
      background: var(--white);
    }
    .whatsapp-card {
      background: #25D366;
      border: var(--border);
      box-shadow: 8px 8px 0 var(--black);
      padding: 40px;
      text-align: center;
      transition: transform 0.2s ease, box-shadow 0.2s ease;
      display: block;
      text-decoration: none;
      color: var(--black);
    }
    .whatsapp-card:hover {
      transform: translate(-4px, -4px);
      box-shadow: 12px 12px 0 var(--black);
    }
    .wa-icon {
      width: 80px;
      height: 80px;
      margin: 0 auto 24px;
      background: var(--white);
      border: var(--border);
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      box-shadow: 4px 4px 0 var(--black);
    }
    .wa-title {
      font-size: 36px;
      font-weight: 900;
      text-transform: uppercase;
      margin-bottom: 12px;
    }
    .wa-desc {
      font-size: 18px;
      font-weight: 600;
    }
    .contact-method {
      padding-bottom: 24px;
      border-bottom: 2px dashed #ccc;
    }
    .contact-method:last-child {
      border-bottom: none;
      padding-bottom: 0;
    }
    .cm-label {
      font-family: var(--ff-mono);
      font-size: 14px;
      text-transform: uppercase;
      font-weight: 700;
      color: var(--blue);
      margin-bottom: 8px;
    }
    .cm-value {
      font-size: 24px;
      font-weight: 700;
    }
    .cm-value a {
      color: var(--black);
      text-decoration: none;
      transition: color 0.2s;
    }
    .cm-value a:hover {
      color: var(--red);
    }
"@

$content = $content.Insert($styleEnd, "$css`n  ")

# 2. Replace HTML Body
$startMarker = "<!-- ═══════════════════════════════ HERO ══════════════════════════════ -->"
$endMarker = "<!-- ════════════════════════════ CTA ══════════════════════════════════ -->"
$startIndex = $content.IndexOf($startMarker)
$endIndex = $content.IndexOf($endMarker)

$html = @"
<!-- ═══════════════════════════════ CONTACT SECTION ══════════════════════════════ -->
  <section class="contact-hero">
    <div class="container">
      <div class="hero-eyebrow" style="margin-bottom: 24px;">
        <span class="tag" style="background: var(--black); color: var(--white);">✦ Get In Touch</span>
      </div>
      <h1 class="hero-headline" style="font-size: clamp(52px, 8vw, 100px); color: var(--black);">
        LET'S START A<br>
        <span class="accent" style="color: var(--yellow); -webkit-text-stroke: 3px var(--black);">CONVERSATION.</span>
      </h1>
      
      <div class="contact-grid">
        <div class="contact-left">
          <a href="https://wa.me/919876543210?text=Hi%20Apna%20Graphics!%20I%20want%20to%20discuss%20a%20new%20project." target="_blank" class="whatsapp-card reveal">
            <div class="wa-icon">
              <svg width="40" height="40" viewBox="0 0 24 24" fill="currentColor">
                <path d="M12.031 0C5.385 0 0 5.385 0 12.031C0 14.664 0.846 17.104 2.25 19.141L0.573 23.417L4.99 21.75C6.969 23.01 9.406 23.75 12.031 23.75C18.677 23.75 24.062 18.365 24.062 11.719C24.062 5.073 18.677 0 12.031 0ZM12.031 21.75C9.698 21.75 7.552 20.979 5.813 19.688L5.427 19.458L2.573 20.375L3.521 17.615L3.26 17.188C1.865 15.656 1.042 13.917 1.042 12.031C1.042 5.969 5.969 1.042 12.031 1.042C18.094 1.042 23.021 5.969 23.021 12.031C23.021 18.094 18.094 21.75 12.031 21.75ZM17.917 15.708C17.604 15.542 16.031 14.771 15.719 14.656C15.406 14.542 15.188 14.479 14.958 14.812C14.729 15.146 14.125 15.854 13.927 16.083C13.74 16.312 13.542 16.333 13.229 16.188C12.917 16.031 11.875 15.688 10.635 14.583C9.656 13.708 8.99 12.635 8.802 12.323C8.615 12.01 8.781 11.844 8.938 11.688C9.073 11.552 9.24 11.333 9.396 11.156C9.552 10.969 9.615 10.844 9.771 10.604C9.927 10.365 9.844 10.156 9.771 10C9.688 9.844 9.031 8.219 8.76 7.552C8.5 6.906 8.229 6.99 8.031 6.99C7.844 6.99 7.625 6.99 7.396 6.99C7.167 6.99 6.781 7.073 6.469 7.406C6.156 7.74 5.25 8.594 5.25 10.333C5.25 12.073 6.51 13.74 6.698 13.99C6.885 14.24 9.177 17.781 12.667 19.292C13.5 19.656 14.146 19.875 14.656 20.031C15.49 20.292 16.25 20.26 16.854 20.156C17.531 20.031 18.969 19.26 19.271 18.427C19.573 17.594 19.573 16.885 19.479 16.719C19.385 16.552 19.167 16.458 18.854 16.302L17.917 15.708Z" />
              </svg>
            </div>
            <h2 class="wa-title">Chat on WhatsApp</h2>
            <p class="wa-desc">Fastest way to reach us. We reply within minutes.</p>
            <div style="margin-top:24px; font-family:var(--ff-mono); font-size:14px; color:var(--black); background:rgba(0,0,0,0.1); padding:8px 16px; border-radius:20px; display:inline-block; border: 2px solid var(--black);">+91 98765 43210</div>
          </a>
        </div>
        
        <div class="contact-right reveal" style="transition-delay: 0.1s;">
          <div class="contact-method">
            <div class="cm-label">Drop Us An Email</div>
            <div class="cm-value"><a href="mailto:hello@apnagraphics.in">hello@apnagraphics.in</a></div>
          </div>
          
          <div class="contact-method">
            <div class="cm-label">Call Us Directly</div>
            <div class="cm-value"><a href="tel:+919876543210">+91 98765 43210</a></div>
          </div>
          
          <div class="contact-method">
            <div class="cm-label">Visit Our Studio</div>
            <div class="cm-value" style="font-size: 18px; line-height: 1.5;">
              Studio 401, Hauz Khas Village,<br>
              New Delhi — 110016
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  
"@

$content = $content.Remove($startIndex, $endIndex - $startIndex).Insert($startIndex, $html)
Set-Content "contact.html" -Value $content
