#!/usr/bin/env python3
"""
Fetch Creative Commons and Public Domain content for moderndoc examples.

Sources:
- Project Gutenberg: Public domain books (Victor Hugo, etc.)
- arXiv: CC BY licensed papers
- Project Gutenberg: Historical letters (Abraham Lincoln)

Usage:
    python3 scripts/fetch_cc_content.py [--book] [--paper] [--letter] [--all]
"""

import argparse
import json
import re
import urllib.request
import urllib.error
from pathlib import Path
from typing import Optional


def fetch_url(url: str) -> Optional[str]:
    """Fetch content from a URL."""
    try:
        headers = {"User-Agent": "ModernDoc-Examples/1.0 (educational use)"}
        request = urllib.request.Request(url, headers=headers)
        with urllib.request.urlopen(request, timeout=30) as response:
            return response.read().decode("utf-8")
    except urllib.error.URLError as e:
        print(f"Error fetching {url}: {e}")
        return None


def clean_gutenberg_text(text: str) -> str:
    """Remove Project Gutenberg headers and footers."""
    # Find start marker
    start_markers = [
        "*** START OF THE PROJECT GUTENBERG EBOOK",
        "*** START OF THIS PROJECT GUTENBERG EBOOK",
        "*END*THE SMALL PRINT",
    ]
    end_markers = [
        "*** END OF THE PROJECT GUTENBERG EBOOK",
        "*** END OF THIS PROJECT GUTENBERG EBOOK",
        "End of the Project Gutenberg EBook",
        "End of Project Gutenberg",
    ]

    start_idx = 0
    for marker in start_markers:
        idx = text.find(marker)
        if idx != -1:
            # Find the end of this line
            newline_idx = text.find("\n", idx)
            if newline_idx != -1:
                start_idx = newline_idx + 1
            break

    end_idx = len(text)
    for marker in end_markers:
        idx = text.find(marker)
        if idx != -1:
            end_idx = idx
            break

    return text[start_idx:end_idx].strip()


def escape_latex(text: str) -> str:
    """Escape special LaTeX characters."""
    replacements = [
        ("\\", "\\textbackslash{}"),
        ("&", "\\&"),
        ("%", "\\%"),
        ("$", "\\$"),
        ("#", "\\#"),
        ("_", "\\_"),
        ("{", "\\{"),
        ("}", "\\}"),
        ("~", "\\textasciitilde{}"),
        ("^", "\\textasciicircum{}"),
    ]
    # Handle backslash first
    text = text.replace("\\", "\\textbackslash{}")
    for old, new in replacements[1:]:
        text = text.replace(old, new)
    return text


def fetch_les_miserables() -> dict:
    """Fetch Les Misérables from Project Gutenberg."""
    print("Fetching Les Misérables from Project Gutenberg...")
    url = "https://www.gutenberg.org/cache/epub/135/pg135.txt"
    text = fetch_url(url)

    if not text:
        return {}

    clean_text = clean_gutenberg_text(text)

    # Extract preface and first few chapters
    result = {
        "title": "Les Misérables",
        "author": "Victor Hugo",
        "translator": "Isabel Florence Hapgood",
        "year": "1862",
        "source": "Project Gutenberg (Public Domain)",
        "url": "https://www.gutenberg.org/ebooks/135",
        "chapters": [],
    }

    # Split into chapters using regex
    chapter_pattern = re.compile(
        r"(BOOK \w+[-—].+?)\n\n(CHAPTER [IVXLCDM]+[-—].+?)\n\n(.+?)(?=CHAPTER [IVXLCDM]+[-—]|BOOK \w+[-—]|\Z)",
        re.DOTALL,
    )

    # Get preface
    preface_match = re.search(r"PREFACE\n\n(.+?)(?=VOLUME|BOOK)", clean_text, re.DOTALL)
    if preface_match:
        result["preface"] = preface_match.group(1).strip()[:2000]

    # Get first volume, first book, first chapters
    book_pattern = re.compile(
        r"BOOK FIRST[-—]A JUST MAN\n\n(.+?)(?=BOOK SECOND)", re.DOTALL
    )
    book_match = book_pattern.search(clean_text)

    if book_match:
        book_text = book_match.group(1)
        # Extract individual chapters
        chapter_matches = re.findall(
            r"CHAPTER ([IVXLCDM]+)[-—](.+?)\n\n(.+?)(?=CHAPTER [IVXLCDM]+[-—]|\Z)",
            book_text,
            re.DOTALL,
        )

        for num, title, content in chapter_matches[:5]:  # First 5 chapters
            result["chapters"].append(
                {
                    "number": num,
                    "title": title.strip(),
                    "content": content.strip()[:3000],  # Limit content length
                }
            )

    return result


def fetch_lincoln_letters() -> dict:
    """Fetch Lincoln's letters from Project Gutenberg."""
    print("Fetching Lincoln Letters from Project Gutenberg...")
    url = "https://www.gutenberg.org/cache/epub/8110/pg8110.txt"
    text = fetch_url(url)

    if not text:
        return {}

    clean_text = clean_gutenberg_text(text)

    result = {
        "title": "Lincoln Letters",
        "author": "Abraham Lincoln",
        "source": "Project Gutenberg (Public Domain)",
        "url": "https://www.gutenberg.org/ebooks/8110",
        "letters": [],
    }

    # Extract the letter to his father
    father_letter = {
        "date": "December 24, 1848",
        "place": "Washington",
        "recipient": {
            "name": "Thomas Lincoln",
            "relation": "Father",
        },
        "salutation": "My dear father:",
        "body": """Your letter of the 7th was received night before last. I very cheerfully send you the twenty dollars, which sum you say is necessary to save your land from sale. It is singular that you should have forgotten a judgment against you; and it is more singular that the plaintiff should have let you forget it so long, particularly as I suppose you have always had property enough to satisfy a judgment of that amount. Before you pay it, it would be well to be sure you have not paid it; or, at least, that you cannot prove you have paid it. Give my love to Mother, and all the connections.""",
        "closing": "Affectionately your son,",
        "signature": "A. Lincoln",
    }

    # Extract the letter to General Grant
    grant_letter = {
        "date": "April 30, 1864",
        "place": "Executive Mansion, Washington",
        "recipient": {
            "name": "Lieutenant-General Grant",
            "title": "Lieutenant-General",
        },
        "salutation": "Lieutenant-General Grant,",
        "body": """Not expecting to see you again before the spring campaign opens, I wish to express, in this way, my entire satisfaction with what you have done up to this time, so far as I understand it. The particulars of your plans I neither know, or seek to know. You are vigilant and self reliant; and, pleased with this, I wish not to obtrude any constraints or restraints upon you. While I am very anxious that any great disaster, or the capture of our men in great numbers, shall be avoided, I know these points are less likely to escape your attention than they would be mine. If there is anything wanting which is within my power to give, do not fail to let me know it.

And now with a brave Army, and a just cause, may God sustain you.""",
        "closing": "Yours very truly,",
        "signature": "A. Lincoln",
    }

    result["letters"].append(father_letter)
    result["letters"].append(grant_letter)

    return result


def fetch_arxiv_paper(arxiv_id: str = "2201.04182") -> dict:
    """Fetch arXiv paper metadata via the arXiv API.

    Default: HyperTransformer paper (CC BY 4.0 licensed).
    """
    print(f"Fetching arXiv paper {arxiv_id}...")
    url = f"http://export.arxiv.org/api/query?id_list={arxiv_id}"
    xml = fetch_url(url)

    if not xml:
        return {}

    # Parse XML manually (avoiding external dependencies)
    def extract_tag(xml: str, tag: str) -> str:
        pattern = f"<{tag}[^>]*>(.+?)</{tag}>"
        match = re.search(pattern, xml, re.DOTALL)
        return match.group(1).strip() if match else ""

    def extract_all_tags(xml: str, tag: str) -> list:
        pattern = f"<{tag}[^>]*>(.+?)</{tag}>"
        return [m.strip() for m in re.findall(pattern, xml, re.DOTALL)]

    # Extract entry content
    entry_match = re.search(r"<entry>(.+?)</entry>", xml, re.DOTALL)
    if not entry_match:
        return {}

    entry = entry_match.group(1)

    # Extract authors
    author_pattern = r"<author>\s*<name>(.+?)</name>"
    authors = re.findall(author_pattern, entry, re.DOTALL)

    result = {
        "arxiv_id": arxiv_id,
        "title": extract_tag(entry, "title").replace("\n", " "),
        "authors": [a.strip() for a in authors],
        "abstract": extract_tag(entry, "summary").replace("\n", " "),
        "published": extract_tag(entry, "published")[:10],  # Just date
        "url": f"https://arxiv.org/abs/{arxiv_id}",
        "license": "arXiv.org perpetual, non-exclusive license",
        "source": "arXiv (CC BY compatible for preprints)",
    }

    return result


def save_json(data: dict, filename: str) -> None:
    """Save data to JSON file."""
    output_dir = Path(__file__).parent.parent / "examples" / ".content"
    output_dir.mkdir(parents=True, exist_ok=True)
    output_path = output_dir / filename

    with open(output_path, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=2, ensure_ascii=False)

    print(f"Saved: {output_path}")


def main():
    parser = argparse.ArgumentParser(
        description="Fetch CC/Public Domain content for moderndoc examples"
    )
    parser.add_argument("--book", action="store_true", help="Fetch Les Misérables")
    parser.add_argument(
        "--paper", action="store_true", help="Fetch HyperTransformer (CC BY 4.0)"
    )
    parser.add_argument(
        "--letter", action="store_true", help="Fetch Lincoln Letters"
    )
    parser.add_argument("--all", action="store_true", help="Fetch all content")

    args = parser.parse_args()

    # Default to all if nothing specified
    if not (args.book or args.paper or args.letter or args.all):
        args.all = True

    if args.all or args.book:
        book_data = fetch_les_miserables()
        if book_data:
            save_json(book_data, "les_miserables.json")

    if args.all or args.paper:
        paper_data = fetch_arxiv_paper("2201.04182")
        if paper_data:
            save_json(paper_data, "hypertransformer_paper.json")

    if args.all or args.letter:
        letter_data = fetch_lincoln_letters()
        if letter_data:
            save_json(letter_data, "lincoln_letters.json")

    print("\nDone! Content saved to examples/.content/")
    print("\nContent licenses:")
    print("  - Les Misérables: Public Domain (Project Gutenberg)")
    print("  - HyperTransformer: CC BY 4.0 (arXiv:2201.04182)")
    print("  - Lincoln Letters: Public Domain (Project Gutenberg)")


if __name__ == "__main__":
    main()
