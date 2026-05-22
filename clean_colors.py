import os
import re

def process_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    original_content = content
    
    # Remove Scaffold backgroundColor overrides
    content = re.sub(r'^\s*backgroundColor:\s*(?:const\s+)?Color\([^)]+\),?\s*(?://.*)?\n', '', content, flags=re.MULTILINE)
    
    # We shouldn't blindly remove all colors because some might be semantic (like error red or favorite).
    # But let's remove common structural colors:
    
    # Remove hardcoded text colors that are Slate/Gray (usually body text)
    content = re.sub(r'color:\s*(?:const\s+)?Color\(0xFF(?:94A3B8|64748B)\),?\s*(?://.*)?\n', '', content, flags=re.MULTILINE)
    
    # Remove hardcoded slate/background colors from containers and cards
    content = re.sub(r'color:\s*(?:const\s+)?Color\(0xFF(?:1E293B|0F172A)\),?\s*(?://.*)?\n', '', content, flags=re.MULTILINE)
    
    if content != original_content:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Updated {filepath}")

def main():
    lib_dir = os.path.join(os.getcwd(), 'lib')
    for root, _, files in os.walk(lib_dir):
        for file in files:
            if file.endswith('.dart'):
                process_file(os.path.join(root, file))

if __name__ == "__main__":
    main()
