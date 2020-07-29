import sys

sys.path.append("../../mypy")
import File
from Storage import Storage

storage = Storage()
storage.create_bucket("abadpour-com")

for filename in File.list_of("../*.pdf"):
    print(f"uploading {filename}")
    storage.upload_file(filename, "abadpour-com", f"cv/{File.name_and_extension(filename)}")
