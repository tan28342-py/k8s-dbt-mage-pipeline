FROM mageai/mageai:0.9.80
COPY mage-requirements.txt /home/src/requirements.txt
RUN pip install --no-cache-dir -r /home/src/requirements.txt